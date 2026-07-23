import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class MorderModel: Identifiable, ObservableObject {
    @Published public var morders = [Morder]()
    
    let sqlQuerySELECT = """
        SELECT
            id,          -- $0
            number,      -- $1
            date,        -- $2
            department,  -- $3
            person_id,   -- $4
            title,       -- $5
            body,        -- $6
            note         -- $7
        FROM
            morder.vw_morder
        ORDER BY
            date, number
        ;
    """
    
    /// For DEBUG purposes
    ///
    public init(morders: [Morder]) {
        self.morders = morders
    }
    
    public init() {
        reload()
    }
    
    func reload() {
        morders = []
        
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
                let number = try columns[1].int()
                let datePg = try columns[2].date()
                let department = try? columns[3].string()
                let personId = try? columns[4].int()
                let title = try? columns[5].string()
                let body = try? columns[6].string()
                let note = try? columns[7].string()
                
                /// The UTC/GMT time zone.
                let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                let date: Date = datePg.date(in: utcTimeZone)
                
                morders.append(
                    Morder(id: id, number: number, date: date, department: department, personId: personId, title: title, body: body, note: note)
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - MorderModel samples

#if DEBUG
public extension MorderModel {
    static let morders: [Morder] = [
        Morder.example
    ]
    
    static let example = samples[0]
    
    static let samples: [MorderModel] = [
        MorderModel(morders: morders)
    ]
}
#endif

// MARK: - Additional Functions

public extension MorderModel {
    
    func findMorder(byId id: Int) -> Morder? {
        if let morder = morders.filter({ $0.id == id }).first {
            return morder
        }
        return nil
    }

//    func findMorder(for internship: Internship) -> Morder? {
//        if let morderId = internship.morderId {
//            if let morder = morders.filter({ $0.id == morderId }).first {
//                return morder
//            }
//        }
//        return nil
//    }
}

// MARK: - DML SQL functions

public extension MorderModel {
    
    // SQL INSERT
    
    func sqlMorderINSERT(_ morder: Morder) {
        let sqlQueryINSERT = """
            INSERT INTO
                morder.vw_morder (
                    number,      -- $1
                    date,        -- $2
                    department,  -- $3
                    person_id,   -- $4
                    title,       -- $5
                    body,        -- $6
                    note         -- $7
                )
            VALUES (
                    $1,   -- number
                    $2,   -- date
                    $3,   -- department
                    $4,   -- person_id
                    $5,   -- title
                    $6,   -- body
                    $7    -- note
            )
            """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryINSERT)
            defer { statement.close() }
            
            var datePg: PostgresDate {
                return morder.date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            let _ = try statement.execute(
                parameterValues: [
                    morder.number,      // $1
                    datePg,             // $2
                    morder.department,  // $3
                    morder.personId,    // $4
                    morder.title,       // $5
                    morder.body,        // $6
                    morder.note         // $7
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
    
    // SQL UPDATE
        
    func sqlMorderUPDATE(_ morder: Morder) {
        let sqlQueryUPDATE = """
            UPDATE
                morder.vw_morder
            SET
                number = $2,
                date = $3,
                department = $4,
                person_id = $5,
                title = $6,
                body = $7,
                note = $8
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
            var datePg: PostgresDate {
                morder.date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
//            var morderId: String? {
//                if let id = data.morder?.id {
//                    return String(id)
//                } else {
//                    return nil
//                }
//            }
            
            let _ = try statement.execute(
                parameterValues: [
                    morder.id,          // 1
                    morder.number,      // 2
                    datePg,             // 3
                    morder.department,  // 4
                    morder.personId,    // 5
                    morder.title,       // 6
                    morder.body,        // 7
                    morder.note         // 8
                ]
            )
        } catch {
            print(error)
        }
        
        self.reload()
    }
    
    // SQL DELETE

    func sqlMorderDELETE(_ morder: Morder) {
        let sqlQueryDELETE = """
            DELETE FROM
                morder.vw_morder
            WHERE
                id = $1
        """

        let id = morder.id
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    String(id)
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
}
