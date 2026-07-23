import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class SectorPoolModel: Identifiable, ObservableObject {
    @Published public var pools = [SectorPool]()
    
    let sqlQuerySELECT = """
        SELECT
            id,    -- 0
            label,  -- 1
            note   -- 2
        FROM
            sector.pool
    """
    
    public init() {
        reload()
    }
    
    func reload() {
        pools = []
        
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
                let label = try columns[1].string()
                let note = try? columns[2].string()
                
                pools.append(
                    SectorPool(id: id, label: label, note: note)
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Additional Functions

public extension SectorPoolModel {
    
    func findSectorPool(byId id: Int) -> SectorPool? {
        if let pool = pools.filter({ $0.id == id }).first {
            return pool
        }
        return nil
    }

    func findSectorPool(for person: Person) -> SectorPool? {
        if let id = person.sectorPoolId {
            if let pool = pools.filter({ $0.id == id }).first {
                return pool
            }
        }
        return nil
    }
}
