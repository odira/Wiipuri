import Foundation
import PostgresClientKit
import SwiftUI
import WiiKit

class HolidayModel: Identifiable, ObservableObject {
    @Published var holidays = [Holiday]()
    
    let sqlQueryText = """
        SELECT
            id, date, name, holiday_type_id, note
        FROM
            calendar.holiday;
    """
    
    init(connection: PostgresClientKit.Connection) {
        fetchData(connection: connection)
    }
    
    init() {
        fetchData()
    }
    
    func fetchData(connection: PostgresClientKit.Connection) {
        do {
            let statement = try connection.prepareStatement(text: sqlQueryText)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let date = try columns[1].string()
                let name = try columns[2].string()
                let holidayTypeId = try columns[3].int()
                let note = try? columns[4].string()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let holidayType = getHolidayType(typeId: holidayTypeId)
                
                holidays.append(
                    Holiday(id: id, date: formatter.date(from: date)!, name: name, holidayType: holidayType,  note: note)
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
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let date = try columns[1].string()
                let name = try columns[2].string()
                let holidayTypeId = try columns[3].int()
                let note = try? columns[4].string()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let holidayType = getHolidayType(typeId: holidayTypeId)
                
                holidays.append(
                    Holiday(id: id, date: formatter.date(from: date)!, name: name, holidayType: holidayType,  note: note)
                )
            }
        } catch {
            print(error)
        }
    }
    
    func isHoliday(of date: Date) -> Bool {
        for holiday in holidays {
            if Calendar.current.isDate(date, inSameDayAs: holiday.date) && holiday.holidayType == .holiday {
                return true
            }
        }
        return false
    }
    
    func isDayOff(of date: Date) -> Bool {
        for holiday in holidays {
            if Calendar.current.isDate(date, inSameDayAs: holiday.date) && holiday.holidayType == .dayoff {
                return true
            }
        }
        return false
    }
    
    private func getHolidayType(typeId: Int) -> HolidayType {
        switch typeId {
        case 1: return .holiday
        case 2: return .dayoff
        case 3: fallthrough
        default:
            return .working
        }
    }
}
