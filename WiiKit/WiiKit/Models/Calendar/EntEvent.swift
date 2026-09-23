import Foundation
import SwiftUI

public struct EntEvent: Identifiable {
    public var id: Int
    public var date: Date
    public var shiftNum: Int?
    public var activityId: Int
    public var note: String?
    
    public init(
        id: Int,
        date: Date,
        shiftNum: Int?,
        activityId: Int,
        note: String?
    ) {
        self.id = id
        self.date = date
        self.shiftNum = shiftNum
        self.activityId = activityId
        self.note = note
    }
}

#if DEBUG
public extension EntEvent {
    static let example = EntEvent(
        id: 1,
        date: Date(),
        shiftNum: 6,
        activityId: 21,
        note: "TEST"
    )
}
#endif
