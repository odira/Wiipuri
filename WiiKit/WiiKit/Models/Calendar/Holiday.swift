import Foundation
import SwiftUI

public enum HolidayType {
    case holiday
    case dayoff
    case working
}

public struct Holiday: Identifiable {
    public var id: Int
    public var date: Date
    public var name: String
    public var holidayType: HolidayType
    public var note: String?
    
    public init(
        id: Int,
        date: Date,
        name: String,
        holidayType: HolidayType,
        note: String?
    ) {
        self.id = id
        self.date = date
        self.name = name
        self.holidayType = holidayType
        self.note = note
    }
}

#if DEBUG
public extension Holiday {
    static let example = Holiday(
        id: 16,
        date: Date(),
        name: "Перенос выходного дня",
        holidayType: .dayoff,
        note: "Перенос выходного дня"
    )
}
#endif
