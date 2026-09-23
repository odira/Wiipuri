import Foundation
import SwiftUI

public struct Sector: Identifiable {
    public var id: Int
    public var label: String
    public var poolId: Int
    public var note: String?
    
    public init(
        id: Int,
        label: String,
        poolId: Int,
        note: String?
    ) {
        self.id = id
        self.label = label
        self.poolId = poolId
        self.note = note
    }
}

#if DEBUG
public extension Sector {
    static let example = samples[0]

    static let samples = [
        Sector(id: 1, label: "M1", poolId: 6, note: "TESTING")
    ]
}
#endif
