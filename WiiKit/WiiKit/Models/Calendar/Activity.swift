import Foundation
import SwiftUI

public struct Activity: Identifiable {
    public var id: Int
    public var icon: String?
    public var abbr: String
    public var activity: String
    public var color: Color
    public var note: String?
    
    public init(
        id: Int,
        icon: String?,
        abbr: String,
        activity: String,
        color: Color,
        note: String?
    ) {
        self.id = id
        self.icon = icon
        self.abbr = abbr
        self.activity = activity
        self.color = color
        self.note = note
    }
}

#if DEBUG
public extension Activity {
    static let example = samples[0]

    static let samples = [
        Activity(id: 3, icon: "🍸", abbr: "опг", activity: "отпуск п/г", color: Color.red, note: "Отпуск по графику"),
        Activity(id: 4, icon: "💊", abbr: "б/л", activity: "больничный лист", color: Color.green, note: "Больничный лист")
    ]
}
#endif
