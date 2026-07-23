import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class EntEventModel: Identifiable, ObservableObject {
    @Published public var entEvents = [EntEvent]()
    
    let sqlQueryText = """
        SELECT
            id, date, shift_num, activity_id, note
        FROM
            calendar.ent_shedule;
    """
    
    public init() {
        fetchData()
    }
    
    func fetchData() {
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryText)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let date = try columns[1].string()
                let shiftNum = try? columns[2].int()
                let activityId = try columns[3].int()
                let note = try? columns[4].string()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                entEvents.append(
                    EntEvent(
                        id: id,
                        date: formatter.date(from: date)!,
                        shiftNum: shiftNum,
                        activityId: activityId,
                        note: note
                    )
                )
            }
        } catch {
            print(error)
        }
    }
    
    public func isEntEvent(of date: Date) -> Bool {
        for event in entEvents {
            if Calendar.current.isDate(date, inSameDayAs: event.date) {
                return true
            }
        }
        return false
    }
    
    public func getEntEvent(of date: Date, shift: Int) -> EntEvent? {
        for event in entEvents {
            if Calendar.current.isDate(date, inSameDayAs: event.date) && shift == event.shiftNum {
                return event
            }
        }
        return nil
    }
}
