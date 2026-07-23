import Foundation
import PostgresClientKit
import SwiftUI
import WiiKit

class PersonnelModel: ObservableObject {
    @Published var persons: [Person] = [Person]()
    
    @ObservedObject var data = Data.shared
//    private var shiftNum = 6
    
    private let sqlQueryText = """
        SELECT
            id, surname, name, middlename, sex, birthday, mobile_phone, email, tab_num, position, class, shift_num,
            sectors_pool_id, pool,
            service_period, note
        FROM
            person.vw_person
        WHERE
            shift_num=$1 AND UPPER(service_period) IS NULL
        ORDER BY
            surname, name;
    """
    
    init(connection fromConnection: PostgresClientKit.Connection) {
        reload(connection: fromConnection)
    }
    
    init() {
        reload()
    }
    
    func reload(connection: PostgresClientKit.Connection) {
        persons = []
        fetchData(connection: connection)
    }
    
    func reload() {
        persons = []
        fetchData()
    }
    
    func fetchData(connection: PostgresClientKit.Connection) {
        do {
            let statement = try connection.prepareStatement(text: sqlQueryText)
            defer { statement.close() }
            
            /// First parameter - shift number
            let cursor = try statement.execute(parameterValues: [data.shiftNum])
//            let cursor = try statement.execute(parameterValues: [shiftNum])
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let surname = try columns[1].string()
                let name = try columns[2].string()
                let middleName = try columns[3].string()
                let sex = try? columns[4].string().toSex()
                let birthday = try? columns[5].date()
                let mobilePhone = try? columns[6].int()
                let email = try? columns[7].string()
                let tabNum = try? columns[8].int()
                let position = try? columns[9].string()
                let klass = try? columns[10].int()
                let shiftNum = try? columns[11].int()
                let sectorsPoolId = try? columns[12].int()
                let sectorsPool = try? columns[13].string()
                let servicePeriod = try? columns[14].string().toDateInterval()
                let note = try? columns[15].string()
                
                self.persons.append(Person(id: id, surname: surname, name: name, middleName: middleName, sex: sex, birthday: birthday, mobilePhone: mobilePhone, email: email, tabNum: tabNum, position: position, klass: klass, shiftNum: shiftNum,
                    sectorsPoolId: sectorsPoolId, sectorsPool: sectorsPool, servicePeriod: servicePeriod, note: note))
            }
        }
        catch {
            print(error)
        }
    }
    
    func fetchData() {
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryText)
            defer { statement.close() }
            
            /// First parameter - shift number
            let cursor = try statement.execute(parameterValues: [data.shiftNum])
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let surname = try columns[1].string()
                let name = try columns[2].string()
                let middleName = try columns[3].string()
                let sex = try? columns[4].string().toSex()
                let birthday = try? columns[5].date()
                let mobilePhone = try? columns[6].int()
                let email = try? columns[7].string()
                let tabNum = try? columns[8].int()
                let position = try? columns[9].string()
                let klass = try? columns[10].int()
                let shiftNum = try? columns[11].int()
                let sectorsPoolId = try? columns[12].int()
                let sectorsPool = try? columns[13].string()
                let servicePeriod = try? columns[14].string().toDateInterval()
                let note = try? columns[15].string()
                
                self.persons.append(Person(id: id, surname: surname, name: name, middleName: middleName, sex: sex, birthday: birthday, mobilePhone: mobilePhone, email: email, tabNum: tabNum, position: position, klass: klass, shiftNum: shiftNum,
                    sectorsPoolId: sectorsPoolId, sectorsPool: sectorsPool, servicePeriod: servicePeriod, note: note))
            }
        }
        catch {
            print(error)
        }
    }
    
    func example() -> [Person] {
        var persons: [Person] = []
        persons.append(Person.example)
        return persons
    }
    
//    func servicePeriod(_ lower: PostgresDate?, _ upper: PostgresDate?) -> DateInterval {
//        /// The UTC/GMT time zone.
//        let utcTimeZone = TimeZone(secondsFromGMT: 0)!
//
//        let lowerDate = lower?.date(in: utcTimeZone) ?? Date()
//        let upperDate = upper?.date(in: utcTimeZone) ?? Date()
//
//        return DateInterval(start: lowerDate, end: upperDate)
//    }
}


