import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class InternshipTypeModel: ObservableObject {
    @Published public var types = [InternshipType]()
    
    let sqlQuerySELECT = """
        SELECT
            id,
            abbr,
            name,
            note,
            color,
            path,
            icon
        FROM
            internship.vw_type
        ORDER BY abbr
    """
    
    public init(types: [InternshipType]) {
        self.types = types
    }
    
    public init() {
        reload()
    }
    
    func reload() {
        types = []
        
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
                let abbr = try columns[1].string()
                let name = try columns[2].string()
                let note = try? columns[3].string()
                let colorString = try columns[4].string()
                let path = try columns[5].string()
                let icon = try? columns[6].string()
                
                #if os(iOS)
                    let color = Color(UIColor(hexString: colorString))
                #elseif os(macOS)
                    let color = Color(NSColor(hexString: colorString))
                #endif
                
                types.append(
                    InternshipType(
                        id: id,
                        abbr: abbr,
                        name: name,
                        note: note,
                        color: color,
                        path: path,
                        icon: icon
                    )
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - InternshipTypeModel Example

#if DEBUG
public extension InternshipTypeModel {
    static let types: [InternshipType] = [
        InternshipType.example
    ]
    
    static let example = samples[0]
    
    static let samples: [InternshipTypeModel] = [
        InternshipTypeModel(types: types)
    ]
}
#endif

// MARK: - InternshipTypeModel Additional Functions

public extension InternshipTypeModel {
    
    func findInternshipType(byId id: Int) -> InternshipType? {
        if let type = types.filter({ $0.id == id }).first {
            return type
        }
        return nil
    }

//    func findInternship(for person: Person) -> Position? {
//        if let positionId = person.positionId {
//            if let position = positions.filter({ $0.id == positionId }).first {
//                return position
//            }
//        }
//        return nil
//    }
}

