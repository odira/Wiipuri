import PostgresClientKit
import SwiftUI
import Combine


public class UnitModel: Identifiable, ObservableObject {
    
    @Published public var units = [Unit]()
    @Published public var isFetching: Bool = true
    
    
    public init(units: [Unit]) {
        self.units.removeAll()
        self.units = units
    }
    
    public init() {
        self.units.removeAll()
    }
    
    
    @MainActor
    public func fetch() async {
        self.units.removeAll()
        
        self.isFetching = true
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "tercas"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            let sqlText = "SELECT * FROM unit.vw_unit"
            let statement = try connection.prepareStatement(text: sqlText)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()         //  0
                let parentId = try columns[1].int()   //  1
                let typeId = try? columns[2].int()    //  2
                let type = try? columns[3].string()   //  3
                let abbr = try? columns[4].string()   //  4
                let unit = try? columns[5].string()   //  5
                let cityId = try? columns[6].int()    //  6
                let city = try? columns[7].string()   //  7
                let adId = try? columns[8].int()      //  8
                let ad = try? columns[9].string()     //  9
                let icao = try? columns[10].string()  // 10
                let note = try? columns[11].string()  // 11
                
                units.append(
                    Unit(
                        id: id,                       //  0
                        parentId: parentId,           //  1
                        typeId: typeId,               //  2
                        type: type,                   //  3
                        abbr: abbr,                   //  4
                        unit: unit,                   //  5
                        cityId: cityId,               //  6
                        city: city,                   //  7
                        adId: adId,                   //  8
                        ad: ad,                       //  9
                        icao: icao,                   // 10
                        note: note                    // 11
                    )
                )
            }
        } catch {
            print(error)
        }
        
        isFetching = false
    }
}


// MARK: - EventModel example

#if DEBUG
public extension UnitModel {
    
    static let unitExamples: [Unit] = [
        Unit.example
    ]
    
    static let example = samples[0]
    static let samples: [UnitModel] = [
        UnitModel(units: unitExamples)
    ]
    
}
#endif
