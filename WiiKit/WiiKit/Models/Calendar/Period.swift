import Foundation
import SwiftUI
import PostgresClientKit

// MARK: struct Period definition

public struct Period: Identifiable, Equatable, Hashable {
    public var id: Int
    public var personId: Int
    public var activityId: Int
    public var planning: Bool
    public var period: DateInterval
    public var note: String?
    
    public init(
        id: Int = -1,
        personId: Int = -1,
        activityId: Int = 9, /// 9 - отпуск вне графика
        planning: Bool = false,
        period: DateInterval = DateInterval(),
        note: String? = nil
    ) {
        self.id = id
        self.personId = personId
        self.activityId = activityId
        self.planning = planning
        self.period = period
        self.note = note
    }
}

#if DEBUG
public extension Period {
    static let example = samples[0]
    
    static let samples: [Period] = [
        Period(
            id: 3009,
            personId: 2022,
            activityId: 33,
            planning: true,
            period: DateInterval(
                start: Date.now,
                end: Date.now.addingTimeInterval(60 * 60 * 24 * 10)
            ),
            note: "TEST"
        )
    ]
}
#endif

//// MARK: Extension for data manipulation
//
//public extension Period {
//    struct Data {
//        public var personId: Int
//        public var activityId: Int
//        public var planning: Bool
//        public var period: DateInterval
//        public var note: String
//
//        public init(personId: Int = 0, activityId: Int = 0, planning: Bool = false, period: DateInterval = DateInterval(), note: String? = nil) {
//            self.personId = personId
//            self.activityId = activityId
//            self.planning = planning
//            self.period = period
////            if let note {
////                self.note = note
////            } else {
////                self.note = ""
////            }
//            self.note = note ?? ""
//        }
//    }
//
//    var data: Data {
//        Data(personId: personId, activityId: activityId, planning: planning, period: period, note: note)
//    }
//}

//// MARK: SQL functions
//
//public extension Period {
//    // MARK: SQL UPDATE
//    
//    func sqlUpdatePeriod(from data: Data) {
//        let sqlQueryUpdate = """
//        UPDATE calendar.vw_empl_shedule
//        SET person_id=$2,
//            activity_id=$3,
//            planning=$4,
//            start_date=$5,
//            end_date=$6,
//            note=$7
//        WHERE
//            id=$1
//        """
//        
//        do {
//            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
//            defer { connection.close() }
//            
//            let statement = try connection.prepareStatement(text: sqlQueryUpdate)
//            defer { statement.close() }
//            
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            
//            let _ = try statement.execute(
//                parameterValues: [
//                    String(self.id),
//                    String(data.personId),
//                    String(data.activityId),
//                    data.planning,
//                    formatter.string(from: data.period.start),
//                    formatter.string(from: data.period.end),
//                    data.note
//                ]
//            )
//        }
//        catch {
//            print(error)
//        }
//    }
//}
//    
//// MARK: SQL: CREATE
//
//fileprivate let sqlQueryInsert = """
//    INSERT INTO
//        calendar.vw_empl_shedule(
//            person_id,
//            activity_id,
//            planning,
//            start_date,
//            end_date,
//            note
//        )
//    VALUES (
//            $1, -- person_id
//            $2, -- activity_id
//            $3, -- planning
//            $4, -- start_date
//            $5, -- end_date
//            $6  -- note
//    )
//"""
//
//public func sqlInsertPeriod(
//    personId: Int,
//    activityId: Int,
//    planning: Bool,
//    startDate: Date,
//    endDate: Date,
//    note: String
//) {
//    do {
//        let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
//        defer { connection.close() }
//        
//        let statement = try connection.prepareStatement(text: sqlQueryInsert)
//        defer { statement.close() }
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        let _ = try statement.execute(
//            parameterValues: [
//                String(personId),
//                String(activityId),
//                planning,
//                formatter.string(from: startDate),
//                formatter.string(from: endDate),
//                note
//            ]
//        )
//    }
//    catch {
//        print(error)
//    }
//}
//
//public func sqlInsertPeriod(data: Period.Data) {
//    do {
//        let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
//        defer { connection.close() }
//        
//        let statement = try connection.prepareStatement(text: sqlQueryInsert)
//        defer { statement.close() }
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        let _ = try statement.execute(
//            parameterValues: [
//                String(data.personId),
//                String(data.activityId),
//                data.planning,
//                formatter.string(from: data.period.start),
//                formatter.string(from: data.period.end),
//                data.note
//            ]
//        )
//    }
//    catch {
//        print(error)
//    }
//}
//
//// MARK: - SQL DELETE
//
//fileprivate let sqlQueryDelete = """
//    DELETE FROM
//        calendar.vw_empl_shedule
//    WHERE
//        id=$1 -- id
//"""
//
//// Delete by id
//public func sqlDeletePeriod(byId: Int) {
//    do {
//        let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
//        defer { connection.close() }
//        
//        let statement = try connection.prepareStatement(text: sqlQueryDelete)
//        defer { statement.close() }
//        
//        let _ = try statement.execute(
//            parameterValues: [
//                String(byId)
//            ]
//        )
//    }
//    catch {
//        print(error)
//    }
//}
//
//// Delete by period
//public func sqlDeletePeriod(_ period: Period) {
//    let id = period.id
//    
//    do {
//        let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
//        defer { connection.close() }
//        
//        let statement = try connection.prepareStatement(text: sqlQueryDelete)
//        defer { statement.close() }
//        
//        let _ = try statement.execute(
//            parameterValues: [ String(id) ]
//        )
//    }
//    catch {
//        print(error)
//    }
//}
