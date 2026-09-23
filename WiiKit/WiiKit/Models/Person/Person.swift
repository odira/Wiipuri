import SwiftUI
import Foundation
import PostgresClientKit
import UniformTypeIdentifiers

extension UTType {
    static let Person = UTType(exportedAs: "ru.wiipuri.uttype.Person")
}

// MARK: - struct Person

public struct Person: Identifiable, Codable, Hashable {
    public var id: Int
    public var surname: String
    public var name: String
    public var middleName: String
    public var sex: Person.Sex
    public var birthday: Date?
    public var mobilePhone: Int?
    public var email: String?
    public var tabNum: Int?
    public var positionId: Int?
    public var klass: Int?
    public var shiftNum: Int?
    public var sectorPoolId: Int?
    public var sectorsArr: [Int]
    public var servicePeriod: DateInterval?
    public var positionsArr: [Int]
    public var note: String?
    
//    init() throws
    
    public init(
        id: Int = -1,
        surname: String = "",
        name: String = "",
        middleName: String = "",
        sex: Person.Sex = .male,
        birthday: Date? = nil,
        mobilePhone: Int? = nil,
        email: String? = nil,
        tabNum: Int? = nil,
        positionId: Int? = nil,
        klass: Int? = nil,
        shiftNum: Int? = nil,
        sectorPoolId: Int? = nil,
        sectorsArr: [Int] = [],
        servicePeriod: DateInterval? = nil,
        positionsArr: [Int] = [],
        note: String? = nil
    ) {
        self.id = id
        self.surname = surname
        self.name = name
        self.middleName = middleName
        self.sex = sex
        self.birthday = birthday
        self.mobilePhone = mobilePhone
        self.email = email
        self.tabNum = tabNum
        self.positionId = positionId
        self.klass = klass
        self.shiftNum = shiftNum
        self.sectorPoolId = sectorPoolId
        self.sectorsArr = sectorsArr
        self.servicePeriod = servicePeriod
        self.positionsArr = positionsArr
        self.note = note
    }
}

// MARK: - struct Sex

extension Person {
    public enum Sex: String, Identifiable, CaseIterable, Codable {
        case male
        case female
        
        public var color: Color {
            switch self {
            case .male: return Color.blue
            case .female: return Color.purple
            }
        }
        
        public var rulabel: String {
            switch self {
            case .male: return "муж"
            case .female: return "жен"
            }
        }
        
        public var label: String {
            switch self {
            case .male: return "male"
            case .female: return "female"
            }
        }
        
        public var sql: String {
            switch self {
            case .male: return "m"
            case .female: return "f"
            }
        }
        
        public var id: String {
            self.rawValue
        }
    }
}

// MARK: - samples

#if DEBUG
public extension Person {
    static let example = samples[0]
    static let samples = [
        Person(id: 2022, surname: "Ильин", name: "Владимир", middleName: "Владимирович", sex: .male, birthday: Date(), mobilePhone: 903_596_76_36, email: "odira@mail.ru", tabNum: 3033, positionId: 19, klass: 1, shiftNum: 6, sectorPoolId: 1, sectorsArr: [88,89,90], servicePeriod: nil, positionsArr: [16,23], note: "")
    ]
}
#endif

// MARK: - UIImage definition from NSImage

#if os(macOS)
import Cocoa
typealias UIImage = NSImage
#endif

// MARK: - extension Person

public extension Person {
    var imageName: String {
        if let tabNum = self.tabNum {
            return String(tabNum)
        } else {
            return String()
        }
    }
    
    var image: Image {
        if (UIImage(named: imageName) != nil) {
            return Image(imageName)
        }
        return Image("nophoto")
    }
    
    var birthDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)!
        
        if let birthday {
            return formatter.string(from: birthday)
        } else {
            return ""
        }
    }
    
    var age: Int? {
        if let birthday {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(secondsFromGMT: 0)!
            let startdate = calendar.startOfDay(for: birthday)
            let enddate = calendar.startOfDay(for: Date())
            
            let components = calendar.dateComponents([.year], from: startdate, to: enddate)
            return components.year
        } else {
            return nil
        }
    }
    
    var tabNumString: String {
        if let tabNum {
            let formatter = NumberFormatter()
            formatter.numberStyle = .none
            formatter.groupingSeparator = ""
            return formatter.string(from: NSNumber(value: tabNum))!
        } else {
            return ""
        }
    }
    
    var phoneNumber: String {
        if let mobilePhone {
            let phone = String(mobilePhone)

            var output = "+7 ("

            var index = phone.index(phone.startIndex, offsetBy: 0)
            output = output + String(phone[index])

            index = phone.index(phone.startIndex, offsetBy: 1)
            output = output + String(phone[index])

            index = phone.index(phone.startIndex, offsetBy: 2)
            output = output + String(phone[index]) + ") "

            index = phone.index(phone.startIndex, offsetBy: 3)
            output = output + String(phone[index])

            index = phone.index(phone.startIndex, offsetBy: 4)
            output = output + String(phone[index])

            index = phone.index(phone.startIndex, offsetBy: 5)
            output = output + String(phone[index]) + " "

            index = phone.index(phone.startIndex, offsetBy: 6)
            output = output + String(phone[index])

            index = phone.index(phone.startIndex, offsetBy: 7)
            output = output + String(phone[index]) + " "

            index = phone.index(phone.startIndex, offsetBy: 8)
            output = output + String(phone[index])

            index = phone.index(phone.startIndex, offsetBy: 9)
            output = output + String(phone[index])

            return output
        }
        return "Mobile phone N/A"
    }
    
    var initials: String {
        surname + " " + String(name[name.startIndex]) + "." + String(middleName[middleName.startIndex]) + "."
    }
}

// MARK: - Transferable Protocol Implementation

extension Person: Transferable {
    static public var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .Person)
    }
}
