import Foundation
import PostgresClientKit
import SwiftUI
import WiiKit

class ActivityModel: Identifiable, ObservableObject {
    @Published var activities = [Activity]()
    
    let sqlQueryText = """
        SELECT
            id, abbr, activity, color, note
        FROM
            calendar.activity;
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
                let abbr = try columns[1].string()
                let activity = try columns[2].string()
                let colorString = try columns[3].string()
                let note = try? columns[4].string()
                
                #if os(iOS)
                    let color = Color(UIColor(hexString: colorString))
                #elseif os(macOS)
                    let color = Color(NSColor(hexString: colorString))
                #endif
                
                activities.append(
                    Activity(id: id, abbr: abbr, activity: activity, color: color, note: note)
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
                let abbr = try columns[1].string()
                let activity = try columns[2].string()
                let colorString = try columns[3].string()
                let note = try? columns[4].string()
                
                #if os(iOS)
                    let color = Color(UIColor(hexString: colorString))
                #elseif os(macOS)
                    let color = Color(NSColor(hexString: colorString))
                #endif
                
                activities.append(
                    Activity(id: id, abbr: abbr, activity: activity, color: color, note: note)
                )
            }
        } catch {
            print(error)
        }
    }
    
    func findActivity(by id: Int) -> Activity? {
        if let activity = activities.filter({ $0.id == id }).first {
            return activity
        }
        return nil
    }
}
