import Foundation
import Combine
import PostgresClientKit
import SwiftUI

public class PersonModel: ObservableObject {
    @Published public var persons: [Person] = [Person]()
    
    @ObservedObject var global = Global.shared
    
    private let sqlQuerySELECT = """
        SELECT
            id, surname, name, middlename, sex, birthday, mobile_phone, email, tab_num, position_id, class, shift_num, sectors_pool_id, sectors_arr, service_period, positions_arr, note
        FROM
            person.vw_person
        WHERE
            shift_num = $1 AND UPPER(service_period) IS NULL
            -- id = 2195 or id = 2368 or (shift_num = $1 AND UPPER(service_period) IS NULL)
        ORDER BY
            surname, name;
    """

    public init(persons: [Person]) {
        self.persons = persons
    }
    
    public init() {
        reload()
    }

    public func reload() {
        self.persons = []
        fetchData()
    }
    
    func fetchData() {
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQuerySELECT)
            defer { statement.close() }
            
            /// First parameter - shift number
            let cursor = try statement.execute(parameterValues: [global.shiftNum])
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let surname = try columns[1].string()
                let name = try columns[2].string()
                let middleName = try columns[3].string()
                let sex = try columns[4].string().toSex()
                let birthdayPg = try? columns[5].date()
                let mobilePhone = try? columns[6].int()
                let email = try? columns[7].string()
                let tabNum = try? columns[8].int()
                let positionId = try? columns[9].int()
                let klass = try? columns[10].int()
                let shiftNum = try? columns[11].int()
                let sectorPoolId = try? columns[12].int()
                let sectorsArrTmp = try? columns[13].string().toIntArray()
                let servicePeriod = try? columns[14].string().toDateInterval()
                let positionsArrTmp = try? columns[15].string().toIntArray()
                let note = try? columns[16].string()
                
                var sectorsArr: [Int] {
                    if let sectorsArrTmp {
                        return sectorsArrTmp
                    } else {
                        return []
                    }
                }
                
                var positionArr: [Int] {
                    if let positionsArrTmp {
                        return positionsArrTmp
                    } else {
                        return []
                    }
                }
                
                
                var birthday: Date? {
                    if let birthdayPg {
                        /// The UTC/GMT time zone.
                        let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                        
                        return birthdayPg.date(in: utcTimeZone)
                    } else {
                        return nil
                    }
                }
                
                self.persons.append(Person(id: id, surname: surname, name: name, middleName: middleName, sex: sex, birthday: birthday, mobilePhone: mobilePhone, email: email, tabNum: tabNum, positionId: positionId, klass: klass, shiftNum: shiftNum, sectorPoolId: sectorPoolId, sectorsArr: sectorsArr, servicePeriod: servicePeriod, positionsArr: positionArr, note: note))
            }
        }
        catch {
            print(error)
        }
    }
}

// MARK: - Example struct

public extension PersonModel {
    static let persons: [Person] = [
        Person.example
    ]
    
    static let example = samples[0]
    
    static let samples: [PersonModel] = [
        PersonModel(persons: persons)
    ]
}

// MARK: - Additional Functions

extension PersonModel {
    public func findPerson(byId id: Int) -> Person? {
        if let person = self.persons.first(where: { $0.id == id }) {
            return person
        }
        return nil
    }
}

extension PersonModel {
    // MARK: - DML SQL functions

    // MARK: - SQL INSERT

    public func sqlINSERT(_ person: Person) {
        let sqlQueryINSERT = """
            INSERT INTO
                person.vw_person(
                    surname,
                    name,
                    middlename,
                    sex,
                    tab_num
                )
            VALUES (
                    $1, -- surname
                    $2, -- name
                    $3, -- middlename
                    $4, -- sex
                    $5  -- tab_num
            )
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryINSERT)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    person.surname,
                    person.name,
                    person.middleName,
                    person.sex.sql,
                    person.tabNum
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
        
    // MARK: - SQL UPDATE
        
    public func sqlUPDATE(_ person: Person) {
        let sqlQueryUPDATE = """
                UPDATE person.vw_person
                SET surname = $2,
                    name = $3,
                    middlename = $4,
                    sex = $5,
                    birthday = $6,
                    mobile_phone = $7,
                    email = $8,
                    tab_num = $9,
                    position_id = $10,
                    class = $11,
                    shift_num = $12,
                    sectors_pool_id = $13,
                    sectors_arr = $14,
                    service_period = $15,
                    positions_arr = $16,
                    note = $17
                WHERE
                    id=$1
            """

        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }

            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
            defer { statement.close() }
            
            let positionsArrString = person.positionsArr.toString()
            let sectorsArrString = person.sectorsArr.toString()
            
            var postgresBirthday: PostgresDate? {
                if let birthday = person.birthday {
                    return birthday.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
                }
                return nil
            }

            let _ = try statement.execute(
                parameterValues: [
                    person.id,
                    person.surname,
                    person.name,
                    person.middleName,
                    person.sex.sql,
                    postgresBirthday,       // person.birthday
                    person.mobilePhone,
                    person.email,
                    person.tabNum,
                    person.positionId,
                    person.klass,
                    person.shiftNum,
                    person.sectorPoolId,
                    sectorsArrString,
                    nil,                   // person.servicePeriod,
                    positionsArrString,
                    person.note
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }

    // MARK: - SQL DELETE

    public func sqlDELETE(_ person: Person) {
        let sqlQueryDELETE = """
            DELETE FROM
                person.vw_person
            WHERE
                id=$1 -- id
        """

        let id = person.id
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    String(id)
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
}

//fileprivate extension Array where Element == Int {
//    func toString() -> String {
//        var intString = self.compactMap { String($0) }.joined(separator: ",")
//        intString.insert("{", at: intString.startIndex)
//        intString.insert("}", at: intString.endIndex)
//        return intString
//    }
//}

fileprivate extension String {
    func toSex() -> Person.Sex {
        if self == "m" { return .male }
        else { return .female }
    }
    
//    func toIntArray() -> [Int] {
//        var tmpStr = self
//        if tmpStr.isEmpty {
//            return []
//        }
//        
//        tmpStr.removeFirst()
//        tmpStr.removeLast()
//        
//        let array = tmpStr.components(separatedBy: ",")
//        let intArray = array.compactMap { Int($0) }
//        
//        return intArray
//    }
}


