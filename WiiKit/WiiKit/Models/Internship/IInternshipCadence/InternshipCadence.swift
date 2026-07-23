import SwiftUI

// MARK: - InternshipCadence struct definition

public struct InternshipCadence: Identifiable, Hashable {
    public var id: Int
    public var internshipId: Int
    public var suspended: Bool
    public var period: DateInterval
    public var coachId: Int?
    public var note: String?
    public var mandatoryOrder: String?
    public var morderId: Int?
    
    public init(
        id: Int = -1,
        internshipId: Int = -1,
        suspended: Bool = true,
        period: DateInterval = DateInterval(),
        coachId: Int? = nil,
        note: String? = nil,
        mandatoryOrder: String? = nil,
        morderId: Int? = nil
    ) {
        self.id = id
        self.internshipId = internshipId
        self.suspended = suspended
        self.period = period
        self.coachId = coachId
        self.note = note
        self.mandatoryOrder = mandatoryOrder
        self.morderId = morderId
    }
}

// MARK: - InternshipCadence samples

#if DEBUG
public extension InternshipCadence {
    static let example = samples[0]
    
    static let samples = [
        InternshipCadence(
            id: 1,
            internshipId: 2,
            suspended: false,
            period: DateInterval(start: Date(timeIntervalSinceNow: -25_000), end: Date()),
            coachId: 2022,
            note: "EXAMPLE DATA",
            mandatoryOrder: "EXAMPLE DATA",
            morderId: Morder.example.id
        )
    ]
}
#endif
