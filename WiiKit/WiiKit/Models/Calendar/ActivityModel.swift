import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class ActivityModel: Identifiable, ObservableObject {
    @Published public var activities = [Activity]()
    
    let sqlQueryText = """
        SELECT
            id, icon, abbr, activity, color, note
        FROM
            calendar.vw_activity;
    """
    
    public init(connection: PostgresClientKit.Connection) {
        fetchData(connection: connection)
    }
    
    public init() {
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
                let icon = try? columns[1].string()
                let abbr = try columns[2].string()
                let activity = try columns[3].string()
                let colorString = try columns[4].string()
                let note = try? columns[5].string()
                
                #if os(iOS)
                    let color = Color(UIColor(hexString: colorString))
                #elseif os(macOS)
                    let color = Color(NSColor(hexString: colorString))
                #endif
                
                activities.append(
                    Activity(id: id, icon: icon, abbr: abbr, activity: activity, color: color, note: note)
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
                let icon = try? columns[1].string()
                let abbr = try columns[2].string()
                let activity = try columns[3].string()
                let colorString = try columns[4].string()
                let note = try? columns[5].string()
                
                #if os(iOS)
                    let color = Color(UIColor(hexString: colorString))
                #elseif os(macOS)
                    let color = Color(NSColor(hexString: colorString))
                #endif
                
                activities.append(
                    Activity(id: id, icon: icon, abbr: abbr, activity: activity, color: color, note: note)
                )
            }
        } catch {
            print(error)
        }
    }
}


// MARK: - ActivityModel samples

#if DEBUG
public extension ActivityModel {
    static let activity = Activity.example
    static let example = samples[0]
    static let samples = [
        activity
    ]
}
#endif

// MARK: - Additional Functions

public extension ActivityModel {
    func findActivity(byId id: Int) -> Activity? {
        if let activity = activities.filter({ $0.id == id }).first {
            return activity
        }
        return nil
    }
    
    func findActivity(for period: Period?) -> Activity? {
        if let period = period {
            let activityId = period.activityId
            if let activity = activities.filter({ $0.id == activityId }).first {
                return activity
            }
        }
        return nil
    }
}
