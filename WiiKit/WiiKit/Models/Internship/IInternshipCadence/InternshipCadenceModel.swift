import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class InternshipCadenceModel: ObservableObject {
    @Published public var cadences = [InternshipCadence]()
    
    static let shared = InternshipCadenceModel()
    
    private let sqlQuerySELECT = """
        SELECT
            id,             -- 0
            internship_id,  -- 1
            suspended,      -- 2
            period,         -- 3
            coach_id,       -- 4
            note,           -- 5
            morder,         -- 6
            morder_id       -- 7
        FROM
            internship.cadence
        ORDER BY
            period
    """
    
//    @MainActor
    public init() {
        reload()
    }
    
    func reload() {
        cadences = []
                
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQuerySELECT)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let internshipId = try columns[1].int()
                let suspended = try columns[2].bool()
                let period = try? columns[3].string().toDateInterval()
                let coachId = try? columns[4].int()
                let note = try? columns[5].string()
                let mandatoryOrder = try? columns[6].string()
                let morderId = try? columns[7].int()
                
                cadences.append(
                    InternshipCadence(
                        id: id,
                        internshipId: internshipId,
                        suspended: suspended,
                        period: period!,
                        coachId: coachId,
                        note: note,
                        mandatoryOrder: mandatoryOrder,
                        morderId: morderId
                     )
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - InternshipCadenceModel samples

#if DEBUG
public extension InternshipCadenceModel {
    static let internshipCadence = InternshipCadence.example
    
    static let example = samples[0]
    
    static let samples = [
        internshipCadence
    ]
}
#endif

// MARK: - InternshipCadenceModel Additional Functions

public extension InternshipCadenceModel {
    
    func findInternshipCadence(byId id: Int) -> InternshipCadence? {
        if let cadence = cadences.filter({ $0.id == id }).first {
            return cadence
        }
        return nil
    }
    
    func findInternshipCadences(for internshipId: Int) -> [InternshipCadence] {
        let arr = cadences
            .filter { $0.internshipId == internshipId }
            .sorted { $0.period.start < $1.period.start }
        return arr
    }

    func getInternshipStatus(for internship: Internship) -> Internship.Status {
        let filteredAndSorted = cadences
            .filter { $0.internshipId == internship.id }
            .sorted { $0.period.start < $1.period.start }
        
        let currentDate = Date()
        
        if !filteredAndSorted.isEmpty {
            if currentDate > filteredAndSorted.first!.period.start && currentDate < filteredAndSorted.last!.period.end {
                return .pending
            } else if currentDate > filteredAndSorted.last!.period.end {
                return .completed
            }
        }
        
        return .all
    }
    
//    func findInternship(forPerson person: Person) -> Position? {
//        if let positionId = person.positionId {
//            if let position = positions.filter({ $0.id == positionId }).first {
//                return position
//            }
//        }
//        return nil
//    }
}

// MARK: - DML SQL functions

public extension InternshipCadenceModel {

    // MARK: - SQL INSERT
    
    func sqlINSERT(_ cadence: InternshipCadence) {
        let sqlQueryINSERTcadence = """
            INSERT INTO
                internship.vw_cadence (
                    internship_id,  -- 1
                    suspended,      -- 2
                    period,         -- 3
                    coach_id,       -- 4
                    note,           -- 5
                    morder,         -- 6
                    morder_id       -- 7
                )
            VALUES (
                $1,  -- internship_id
                $2,  -- suspended
                $3,  -- period
                $4,  -- coach_id
                $5,  -- note
                $6,  -- morder
                $7   -- morder_id
            )
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryINSERTcadence)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    cadence.internshipId,          // 1
                    cadence.suspended,             // 2
                    cadence.period.toSQLstring(),  // 3
                    cadence.coachId,               // 4
                    cadence.note,                  // 5
                    cadence.mandatoryOrder,        // 6
                    cadence.morderId               // 7
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }

    // MARK: - SQL UPDATE

    func sqlUPDATE(_ cadence: InternshipCadence) {
        let sqlQueryUPDATEcadence = """
            UPDATE
                internship.vw_cadence
            SET
                internship_id = $2,
                suspended = $3,
                period = $4,
                coach_id = $5,
                note = $6,
                morder = $7,
                morder_id = $8
            WHERE
                id = $1
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryUPDATEcadence)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    cadence.id,                    // 1
                    cadence.internshipId,          // 2
                    cadence.suspended,             // 3
                    cadence.period.toSQLstring(),  // 4
                    cadence.coachId,               // 5
                    cadence.note,                  // 6
                    cadence.mandatoryOrder,        // 7
                    cadence.morderId               // 8
                ]
            )
        } catch {
            print(error)
        }
        
        self.reload()
    }

    // MARK: - SQL DELETE

    func sqlDELETE(_ cadence: InternshipCadence) {
        let sqlQueryDELETEcadence = """
            DELETE FROM
                internship.vw_cadence
            WHERE
                id = $1  -- id
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETEcadence)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    cadence.id  // 1
                ]
            )
        } catch {
            print(error)
        }
        
        self.reload()
    }
}
