import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class PositionModel: Identifiable, ObservableObject {
    @Published public var positions = [Position]()
    
    let sqlQuerySELECT = """
        SELECT
            id, icon, position, abbr, department, deprecated, note
        FROM
            person.position
        WHERE deprecated = FALSE;
    """
    
    public init() {
        reload()
    }
    
    func reload() {
        positions = []
        
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
                let icon = try? columns[1].string()
                let position = try columns[2].string()
                let abbr = try? columns[3].string()
                let department = try? columns[4].string()
                let deprecated = try columns[5].bool()
                let note = try? columns[6].string()
                
                positions.append(
                    Position(id: id, icon: icon, position: position, abbr: abbr, department: department, deprecated: deprecated, note: note)
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Additional Functions

public extension PositionModel {
    
    func findPosition(byId id: Int) -> Position? {
        if let position = positions.filter({ $0.id == id }).first {
            return position
        }
        return nil
    }

    func findPosition(for person: Person) -> Position? {
        if let positionId = person.positionId {
            if let position = positions.filter({ $0.id == positionId }).first {
                return position
            }
        }
        return nil
    }
}
