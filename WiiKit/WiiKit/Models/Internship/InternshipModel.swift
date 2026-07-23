import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class InternshipModel: ObservableObject {
    @Published public var internships = [Internship]()
    
    private let sqlQuerySELECT = """
        SELECT
            id,                    -- 0
            planning,              -- 1
            person_id,             -- 2
            type_id,               -- 3
            sectors_arr,           -- 4
            duration,              -- 5
            simulator_check_date,  -- 6
            check_date,            -- 7
            board_check_date,      -- 8
            morders_arr,           -- 9
            note                   -- 10
        FROM
            internship.vw_internship
        ORDER BY
            planning
    """
    
    public init() {
        reload()
    }
    
    public func reload() {
        internships = []
        fetchData()
    }
    
    func fetchData() {
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
                let planning = try columns[1].bool()
                let personId = try columns[2].int()
                let internshipTypeId = try columns[3].int()
                let sectorsArrTmp = try? columns[4].string().toIntArray()
                let duration = try? columns[5].int()
                let simulatorCheckDatePg = try? columns[6].date()
                let checkDatePg = try? columns[7].date()
                let boardCheckDatePg = try? columns[8].date()
                let mordersArrTmp = try? columns[9].string().toIntArray()
                let note = try? columns[10].string()
                
                var sectorsArr: [Int] {
                    if let sectorsArrTmp {
                        return sectorsArrTmp
                    } else {
                        return []
                    }
                }
                var simulatorCheckDate: Date? {
                    if let simulatorCheckDatePg {
                        /// The UTC/GMT time zone.
                        let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                        
                        return simulatorCheckDatePg.date(in: utcTimeZone)
                    } else {
                        return nil
                    }
                }
                var checkDate: Date? {
                    if let checkDatePg {
                        /// The UTC/GMT time zone.
                        let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                        
                        return checkDatePg.date(in: utcTimeZone)
                    } else {
                        return nil
                    }
                }
                var boardCheckDate: Date? {
                    if let boardCheckDatePg {
                        /// The UTC/GMT time zone.
                        let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                        
                        return boardCheckDatePg.date(in: utcTimeZone)
                    } else {
                        return nil
                    }
                }
                var mordersArr: [Int] {
                    if let mordersArrTmp {
                        return mordersArrTmp
                    } else {
                        return []
                    }
                }
                
                internships.append(
                    Internship(
                        id: id,
                        planning: planning,
                        personId: personId,
                        internshipTypeId: internshipTypeId,
                        sectorsArr: sectorsArr,
                        duration: duration,
                        simulatorCheckDate: simulatorCheckDate,
                        checkDate: checkDate,
                        boardCheckDate: boardCheckDate,
                        mordersArr: mordersArr,
                        note: note
                    )
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - InternshipModel samples

#if DEBUG
public extension InternshipModel {
    static let internship = Internship.example
    
    static let example = samples[0]
    
    static let samples = [
        internship
    ]
}
#endif

// MARK: - InternshipModel Additional Functions

public extension InternshipModel {
    
    func findInternship(byId id: Int) -> Internship? {
        if let internship = internships.filter({ $0.id == id }).first {
            return internship
        }
        return nil
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

public extension InternshipModel {
    
    // MARK: - SQL INSERT
    
    func sqlInternshipINSERT(_ internship: Internship) {
        let sqlQueryINSERT = """
            INSERT INTO
                internship.vw_internship (
                    planning,              -- 1
                    person_id,             -- 2
                    type_id,               -- 3
                    sectors_arr,           -- 4
                    duration,              -- 5
                    simulator_check_date,  -- 6
                    check_date,            -- 7
                    board_check_date,      -- 8
                    morders_arr,           -- 9
                    note                   -- 10
                )
            VALUES (
                    $1,   -- planning
                    $2,   -- person_id
                    $3,   -- internship_type_id
                    $4,   -- sectors_arr
                    $5,   -- duration
                    $6,   -- simulator_check_date
                    $7,   -- check_date
                    $8,   -- board_check_date
                    $9,   -- morders_arr
                    $10   -- note
            )
            """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryINSERT)
            defer { statement.close() }
            
            /// Brash up parameters to PostgreSQL format
            ///
            var simulatorCheckDatePg: PostgresDate? {
                if let date = internship.simulatorCheckDate {
                    return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }
            var checkDatePg: PostgresDate? {
                if let date = internship.checkDate {
                    return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }
            var boardCheckDatePg: PostgresDate? {
                if let date = internship.boardCheckDate {
                    return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }
            
            let _ = try statement.execute(
                parameterValues: [
                    internship.planning,                // 1
                    internship.personId,                // 2
                    internship.internshipTypeId,        // 3
                    internship.sectorsArr.toString(),   // 4
                    internship.duration,                // 5
                    simulatorCheckDatePg,               // 6
                    checkDatePg,                        // 7
                    boardCheckDatePg,                   // 8
                    internship.mordersArr.toString(),   // 9
                    internship.note                     // 10
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
    
    // MARK: - SQL UPDATE
        
    func sqlInternshipUPDATE(_ internship: Internship) {
        let sqlQueryUPDATE = """
            UPDATE
                internship.vw_internship
            SET
                planning = $2,
                person_id = $3,
                type_id = $4,
                sectors_arr = $5,
                duration = $6,
                simulator_check_date = $7,
                check_date = $8,
                board_check_date = $9,
                morders_arr = $10,
                note = $11
            WHERE
                id = $1
        """

        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }

            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
            defer { statement.close() }
            
            /// Brash up parameters to PostgreSQL format
            /// 
            var simulatorCheckDatePg: PostgresDate? {
                if let date = internship.simulatorCheckDate {
                    return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }
            var checkDatePg: PostgresDate? {
                if let date = internship.checkDate {
                    return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }
            var boardCheckDatePg: PostgresDate? {
                if let date = internship.boardCheckDate {
                    return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }

            let _ = try statement.execute(
                parameterValues: [
                    internship.id,                      // 1
                    internship.planning,                // 2
                    internship.personId,                // 3
                    internship.internshipTypeId,        // 4
                    internship.sectorsArr.toString(),   // 5
                    internship.duration,                // 6
                    simulatorCheckDatePg,               // 7
                    checkDatePg,                        // 8
                    boardCheckDatePg,                   // 9
                    internship.mordersArr.toString(),   // 10
                    internship.note                     // 11
                ]
            )
        } catch {
            print(error)
        }
        
        self.reload()
    }

    
    // MARK: - SQL DELETE

    func sqlInternshipDELETE(_ internship: Internship) {
        let sqlQueryDELETE = """
            DELETE FROM
                internship.vw_internship
            WHERE
                id = $1  -- id
        """

        let id = internship.id
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    id
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
}
