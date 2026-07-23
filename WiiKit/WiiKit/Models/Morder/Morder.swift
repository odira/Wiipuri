import Foundation
import SwiftUI

public struct Morder: Identifiable, Hashable {
    public var id: Int
    public var number: Int
    public var date: Date
    public var department: String?
    public var personId: Int?
    public var title: String?
    public var body: String?
    public var note: String?
    
    public init(
        id: Int,
        number: Int,
        date: Date,
        department: String? = nil,
        personId: Int? = nil,
        title: String? = nil,
        body: String? = nil,
        note: String? = nil
    ) {
        self.id = id
        self.number = number
        self.date = date
        self.department = department
        self.personId = personId
        self.title = title
        self.body = body
        self.note = note
    }
}

#if DEBUG
public extension Morder {
    static let empty = Morder(id: 0, number: 0, date: Date())
    
    static let example = samples[0]

    static let samples = [
        Morder(
            id: 0,
            number: 0,
            date: Date(),
            department: "Wiipuri",
            personId: 2022,
            title: "TITLE",
            body: "BODY",
            note: "TESTING"
        )
    ]
}
#endif
