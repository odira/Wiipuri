import PostgresClientKit
import SwiftUI
import Combine

// MARK: - HistoryModel definition

public class HistoryModel: ObservableObject {
    @Published public var histories = [History]()
    @Published public var isFetching: Bool = true
   
    public init(histories: [History]) {
        self.histories = []
        self.histories = histories
    }
   
    public init() {
        self.histories = []
    }
    
    public func reload() async {
        await fetch()
    }
    
    @MainActor
    public func fetch() async {
        self.histories.removeAll()
        
        isFetching = true
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "tercas"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }

            let sqlText = """
            SELECT
                id,                    --  0
                event_id,              --  1
                date,                  --  2
                history,               --  3
                answer_to,             --  4
                ref,                   --  5
                note,                  --  6
                recv_letter_num,       --  7
                recv_letter_date,      --  8
                recv_manufacturer_id,  --  9
                recv_unit_id,          -- 10
                send_letter_num,       -- 11
                send_letter_date,      -- 12
                send_manufacturer_id,  -- 13
                send_unit_id           -- 14
            FROM 
                history.vw_history 
            ORDER BY 
                date
            """
        
            let statement = try connection.prepareStatement(text: sqlText)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()                    //  0
                let eventID = try columns[1].int()               //  1
                let datePg = try columns[2].date()               //  2
                let history = try columns[3].string()            //  3
                let answerTo = try? columns[4].string()          //  4
                let ref = try? columns[5].string()               //  5
                let note = try? columns[6].string()              //  6
                let recvLetterNum = try? columns[7].string()     //  7
                let recvLetterDatePg = try? columns[8].date()    //  8
                let recvManufacturerId = try? columns[9].int()   //  9
                let recvUnitId = try? columns[10].int()          // 10
                let sendLetterNum = try? columns[11].string()    // 11
                let sendLetterDatePg = try? columns[12].date()   // 12
                let sendManufacturerId = try? columns[13].int()  // 13
                let sendUnitId = try? columns[14].int()          // 14

                // The UTC/GMT time zone.
                let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                
                var date: Date {
                    return datePg.date(in: utcTimeZone)
                }
                var recvLetterDate: Date? {
                    if let date = recvLetterDatePg {
                        return date.date(in: utcTimeZone)
                    }
                    return nil
                }
                var sendLetterDate: Date? {
                    if let date = sendLetterDatePg {
                        return date.date(in: utcTimeZone)
                    }
                    return nil
                }
                
                histories.append(
                    History(
                        id: id,                                  //  0
                        eventID: eventID,                        //  1
                        date: date,                              //  2
                        history: history,                        //  3
                        answerTo: answerTo,                      //  4
                        ref: ref,                                //  5
                        note: note,                              //  6
                        recvLetterNum: recvLetterNum,            //  7
                        recvLetterDate: recvLetterDate,          //  8
                        recvManufacturerId: recvManufacturerId,  //  9
                        recvUnitId: recvUnitId,                  // 10
                        sendLetterNum: sendLetterNum,            // 11
                        sendLetterDate: sendLetterDate,          // 12
                        sendManufacturerId: sendManufacturerId,  // 13
                        sendUnitId: sendUnitId                   // 14
                    )
                )
            }
            
        } catch {
            print(error)
        }
        
        isFetching = false
    }
}

// MARK: - HistoryModel example

#if DEBUG
public extension HistoryModel {
   
    static let historiesExmpls: [History] = [
        History.example,
        History.example
   ]
   
   static let example = samples[0]
   static let samples: [HistoryModel] = [
        HistoryModel(histories: historiesExmpls)
   ]
   
}
#endif

// MARK: - Additional Functions

public extension HistoryModel {
    
    func findHistoryById(id: Int) -> History? {
        let result = histories.filter { $0.id == id }
        if result.isEmpty {
            return nil
        }
        return result.first
    }
    
    func findFirstHistory(byEventId eventID: Int) -> History? {
        if let result = histories.first(where: { $0.eventID == eventID }) {
            return result
        }
        return nil
    }
    
    func findHistories(byEventId eventID: Int) -> [History]? {
        let result = histories.filter { $0.eventID == eventID }
        if result.isEmpty {
            return nil
        }
        return result
    }
    
}

// MARK: - DML SQL functions

extension HistoryModel {
    
    // MARK: - SQL INSERT
    
    public func sqlINSERT(
        eventID: Int,               //  $1
        date: Date,                 //  $2
        history: String,            //  $3
        answerTo: String?,          //  $4
        ref: String?,               //  $5
        note: String,               //  $6
        recvLetterNum: String?,     //  $7
        recvLetterDate: Date?,      //  $8
        recvManufacturerId: Int?,   //  $9
        recvUnitId: Int?,           // $10
        sendLetterNum: String?,     // $11
        sendLetterDate: Date?,      // $12
        sendManufacturerId: Int?,   // $13
        sendUnitId: Int?            // $14
    )
    async {
        
        let sqlQueryINSERT = """
            INSERT INTO
                event.vw_history(
                    event_id,              --  $1
                    date,                  --  $2
                    history,               --  $3
                    answerTo,              --  $4
                    ref,                   --  $5
                    note,                  --  $6
                    recv_letter_num,       --  $7
                    recv_letter_date,      --  $8
                    recv_manufacturer_id,  --  $9
                    recv_unit_id,          -- $10
                    send_letter_num,       -- $11
                    send_letter_date,      -- $12
                    send_manufacturer_id,  -- $13
                    send_unit_id           -- $14
                )
            VALUES (
                    $1,   -- event_id
                    $2,   -- date
                    $3,   -- history
                    $4,   -- answer_to
                    $5,   -- ref
                    $6,   -- note
                    $7,   -- recv_letter_num
                    $8,   -- recv_letter_date
                    $9,   -- recv_manufacturer_id
                    $10,  -- recv_unit_id
                    $11,  -- send_letter_num
                    $12,  -- send_letter_date
                    $13,  -- send_manufacturer_id
                    $14   -- send_unit_id
            )
        """
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "tercas"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryINSERT)
            defer { statement.close() }
            
            var datePg: PostgresDate {
                return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            var recvLetterDatePg: PostgresDate? = nil
            if let recvLetterDate {
                recvLetterDatePg = recvLetterDate.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            var sendLetterDatePg: PostgresDate? = nil
            if let sendLetterDate {
                sendLetterDatePg = sendLetterDate.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            let _ = try statement.execute(
                parameterValues: [
                    eventID,              //  1
                    datePg,               //  2
                    history,              //  3
                    answerTo,             //  4
                    ref,                  //  5
                    note,                 //  6
                    recvLetterNum,        //  7
                    recvLetterDatePg,     //  8
                    recvManufacturerId,   //  9
                    recvUnitId,           // 10
                    sendLetterNum,        // 11
                    sendLetterDatePg,     // 12
                    sendManufacturerId,   // 13
                    sendUnitId            // 14
                ]
            )
        }
        catch {
            print(error)
        }
        
        await self.reload()
    }
    
    
    // MARK: - SQL UPDATE
    
    // Variant 1
    public func sqlUPDATE(
        eventID: Int,               //  $1
        date: Date,                 //  $2
        history: String,            //  $3
        answerTo: String?,          //  $4
        ref: String?,               //  $5
        note: String,               //  $6
        recvLetterNum: String?,     //  $7
        recvLetterDate: Date?,      //  $8
        recvManufacturerId: Int?,   //  $9
        recvUnitId: Int?,           // $10
        sendLetterNum: String?,     // $11
        sendLetterDate: Date?,      // $12
        sendManufacturerId: Int?,   // $13
        sendUnitId: Int?            // $14
    ) async {
        
        let sqlQueryUPDATE = """
            UPDATE
                event.history
            SET
                date = $2,                  -- date
                history = $3,               -- history
                answer_to = $4,             -- answerTo
                ref = $5,                   -- ref
                note = $6,                  -- note
                recv_letter_num = $7,       -- recvLetterNum
                recv_letter_date = $8,      -- recvLetterDate
                recv_manufacturer_id = $9,  -- recvManufacturerId
                recv_unit_id = $10,         -- recvUnitId
                send_letter_num = $11,      -- sendLetterNum
                send_letter_date = $12,     -- sendLetterDate
                send_manufacturer_id= $13,  -- sendManufacturerId
                send_unit_id = $14          -- sendUnitId
            WHERE
                id = $1                     -- id
        """
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "tercas"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
            defer { statement.close() }
            
            var datePg: PostgresDate {
                return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            var recvLetterDatePg: PostgresDate? = nil
            if let recvLetterDate {
                recvLetterDatePg = recvLetterDate.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            var sendLetterDatePg: PostgresDate? = nil
            if let sendLetterDate {
                sendLetterDatePg = sendLetterDate.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
            }
            
            let _ = try statement.execute(
                parameterValues: [
                    eventID,              //  1
                    datePg,               //  2
                    history,              //  3
                    answerTo,             //  4
                    ref,                  //  5
                    note,                 //  6
                    recvLetterNum,        //  7
                    recvLetterDatePg,     //  8
                    recvManufacturerId,   //  9
                    recvUnitId,           // 10
                    sendLetterNum,        // 11
                    sendLetterDatePg,     // 12
                    sendManufacturerId,   // 13
                    sendUnitId            // 14
                ]
            )
        }
        catch {
            print(error)
        }
        
        await self.reload()
    }
    
//    // Variant 2
//    public func sqlUPDATE(
//        history: History
//    ) async {
//        
//        await sqlUPDATE(
//            id: history.id,
//            date: history.date,
//            history: history.history,
//            answerTo: history.answerTo,
//            ref: history.ref,
//            note: history.note ?? "",
//            recvLetterNum: history.recvLetterNum, // ?? "",
//            recvLetterDate: history.recvLetterDate, // ?? Date(),
//            recvManufacturerId: history.recvManufacturerId,
//            recvUnitId: history.recvUnitId,
//            sendLetterNum: history.sendLetterNum,
//            sendLetterDate: history.sendLetterDate,
//            sendManufacturerId: history.sendManufacturerId,
//            sendUnitId: history.sendUnitId
//        )
//        
////        let sqlQueryUPDATE = """
////            UPDATE
////                event.vw_history
////            SET
////                date = $2,       -- date
////                history = $3,    -- history
////                note = $4,       -- note
////                letter = $5,     -- letter
////                letter_date = $6 -- letterDate
////            WHERE
////                id = $1          -- id
////        """
////        
////        do {
////            var configuration = PostgresClientKit.ConnectionConfiguration()
////            configuration.host = "217.107.219.91"
////            configuration.database = "tercas"
////            configuration.user = "postgres"
////            configuration.credential = .trust // .scramSHA256(password: "monrepo")
////            
////            let connection = try PostgresClientKit.Connection(configuration: configuration)
////            defer { connection.close() }
////            
////            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
////            defer { statement.close() }
////            
////            
////            var datePg: PostgresDate {
////                return history.date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
////            }
////            
////            let _ = try statement.execute(
////                parameterValues: [
////                    history.id,
////                    datePg,
////                    history.history,
////                    history.note
////                ]
////            )
////        }
////        catch {
////            print(error)
////        }
////        
////        await self.reload()
//    }
    
    // MARK: - SQL DELETE
    
    public func sqlDELETE(
        historyId: Int
    ) async {
        
        let sqlQueryDELETE = """
            DELETE FROM
                event.vw_history
            WHERE
                id = $1     -- id
        """
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "tercas"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    historyId
                ]
            )
        }
        catch {
            print(error)
        }
        
        await self.reload()
    }
}
