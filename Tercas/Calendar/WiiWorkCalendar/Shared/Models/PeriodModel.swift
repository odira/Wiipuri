import Foundation
import PostgresClientKit
import SwiftUI
import WiiKit

class PeriodModel: ObservableObject {
    @Published var periods = [Period]()
    
    @ObservedObject var data = Data.shared

    private let sqlQueryText = """
        SELECT
            id, person_id, activity_id, period, note
        FROM
            calendar.vw_empl_shedule
        WHERE
            period && daterange($1, $2, '[]') AND activity_id != 45
        ORDER BY period;
    """
    
    init(connection: PostgresClientKit.Connection) {
        reload()
    }
    
    init() {
        reload()
    }
    
    func reload(connection: PostgresClientKit.Connection) {
        periods = []
        fetchData(connection: connection)
    }
    
    func reload() {
        periods = []
        fetchData()
    }
    
    func fetchData(connection: PostgresClientKit.Connection) {
        do {
            let statement = try connection.prepareStatement(text: sqlQueryText)
            defer { statement.close() }
            
            let start: Date = Calendar.current.extendedMonthInterval(in: data.month)!.start
            let end: Date = Calendar.current.extendedMonthInterval(in: data.month)!.end
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let cursor = try statement.execute(parameterValues: [ formatter.string(from: start) , formatter.string(from: end) ])
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let personId = try columns[1].int()
                let activityId = try columns[2].int()
                let period = try? columns[3].string().toDateInterval()
                let note = try? columns[4].string()
                
                self.periods.append(
                    Period(
                        id: id,
                        personId: personId,
                        activityId: activityId,
                        period: period!,
                        note: note
                    )
                )
            }
        } catch {
            print(error)
        }
    }
    
    func fetchData() {
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryText)
            defer { statement.close() }
            
            let start: Date = Calendar.current.extendedMonthInterval(in: data.month)!.start
            let end: Date = Calendar.current.extendedMonthInterval(in: data.month)!.end
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let cursor = try statement.execute(parameterValues: [ formatter.string(from: start) , formatter.string(from: end) ])
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let personId = try columns[1].int()
                let activityId = try columns[2].int()
                let period = try? columns[3].string().toDateInterval()
                let note = try? columns[4].string()
                
                self.periods.append(
                    Period(
                        id: id,
                        personId: personId,
                        activityId: activityId,
                        period: period!,
                        note: note
                    )
                )
            }
        } catch {
            print(error)
        }
    }
}
