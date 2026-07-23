import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class SectorModel: Identifiable, ObservableObject {
    @Published public var sectors = [Sector]()
    
    let sqlQuerySELECT = """
        SELECT
            id,       -- 0
            label,    -- 1
            pool_id,  -- 2
            note      -- 3
        FROM
            sector.sector;
    """
    
    public init() {
        reload()
    }
    
    func reload() {
        sectors = []
        
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
                let poolId = try columns[2].int()
                let note = try? columns[3].string()
                
                sectors.append(
                    Sector(id: id, label: label, poolId: poolId, note: note)
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Example struct

public extension SectorModel {
    static let example = samples[0]
    
    static let samples: [Sector] = [
        Sector.example
    ]
}

// MARK: - Additional Functions

public extension SectorModel {
    func findSector(byId id: Int) -> Sector? {
        if let sector = sectors.filter({ $0.id == id }).first {
            return sector
        }
        return nil
    }
}
