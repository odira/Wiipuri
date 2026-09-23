import Foundation
import SwiftUI

public struct Position: Identifiable {
    public var id: Int
    public var icon: String?
    public var position: String
    public var abbr: String?
    public var department: String?
    public var deprecated: Bool
    public var note: String?
    
    public init(
        id: Int, icon: String? = nil, position: String, abbr: String? = nil, department: String? = "РДЦ", deprecated: Bool = false, note: String?
    ) {
        self.id = id
        self.icon = icon
        self.position = position
        self.abbr = abbr
        self.department = department
        self.deprecated = deprecated
        self.note = note
    }
}

#if DEBUG
public extension Position {
    static let example = samples[0]

    static let samples = [
        Position(id: 10, icon: "🤷‍♂️", position: "Диспетчер РЛУ и ПК", abbr: "Д", department: "РДЦ", deprecated: true, note: "TESTING purpose")
    ]
}
#endif
