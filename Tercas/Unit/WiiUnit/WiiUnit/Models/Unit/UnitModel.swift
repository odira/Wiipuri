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
                
                let id = try columns[0].int()              //  0
                let parentId = try columns[1].int()        //  1
                let typeId = try? columns[2].int()         //  2
                let typeAbbr = try? columns[3].string()    //  3
                let type = try columns[4].string()         //  4
                let typeNote = try? columns[5].string()    //  5
                let abbr = try? columns[6].string()        //  6
                let unit = try columns[7].string()         //  7
                let adId = try? columns[8].int()           //  8
                let cityId = try? columns[9].int()         //  9
                let city = try? columns[10].string()       // 10
                let ops = try columns[11].bool()           // 11
                let note = try? columns[12].string()       // 12
                
                units.append(
                    Unit(
                        id: id,                      //  0
                        parentId: parentId,          //  1
                        typeId: typeId,              //  2
                        typeAbbr: typeAbbr,          //  3
                        type: type,                  //  4
                        typeNote: typeNote,          //  5
                        abbr: abbr,                  //  6
                        unit: unit,                  //  7
                        adId: adId,                  //  8
                        cityId: cityId,              //  9
                        city: city,                  // 10
                        ops: ops,                    // 11
                        note: note                   // 12
                    )
                )
            }
        } catch {
            print(error)
        } // do
        
        isFetching = false
    } // fetch
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
