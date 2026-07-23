import Foundation
import SwiftUI

public struct SectorPool: Identifiable {
    public var id: Int
    public var label: String
    public var note: String?
    
    public init(
        id: Int,
        label: String,
        note: String?
    ) {
        self.id = id
        self.label = label
        self.note = note
    }
}

#if DEBUG
public extension SectorPool {
    static let example = samples[0]

    static let samples = [
        SectorPool(id: 1, label: "Пенза", note: "TESTING")
    ]
}
#endif
