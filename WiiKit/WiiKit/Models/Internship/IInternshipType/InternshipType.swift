import SwiftUI

// MARK: - InternshipType struct definition

public struct InternshipType: Identifiable {
    public var id: Int
    public var abbr: String
    public var name: String
    public var note: String?
    public var color: Color
    public var path: String
    public var icon: String?
    
    public init(
        id: Int,
        abbr: String,
        name: String,
        note: String? = nil,
        color: Color,
        path: String,
        icon: String? = nil
    ) {
        self.id    = id
        self.abbr  = abbr
        self.name  = name
        self.note  = note
        self.color = color
        self.path  = path
        self.icon  = icon
    }
}

// MARK: - InternshipType samples

#if DEBUG
public extension InternshipType {
    static let example = samples[0]
    
    static let samples = [
        InternshipType(
            id: 1,
            abbr: "пл",
            name: "первоначальная подготовка",
            note: "Первоначальная подготовка",
            color: .blue,
            path: "internship.initial",
            icon: nil
        )
    ]
}
#endif
