import SwiftUI
import PostgresClientKit

// MARK: - Internship struct definition

public struct Internship: Identifiable, Hashable {
    public var id: Int
    public var planning: Bool
    public var personId: Int
    public var internshipTypeId: Int
    public var sectorsArr: [Int]
    public var duration: Int?
    public var simulatorCheckDate: Date?
    public var checkDate: Date?
    public var boardCheckDate: Date?
    public var mordersArr: [Int]
    public var note: String?

    public init(
        id: Int = -1,
        planning: Bool = false,
        personId: Int = -1,
        internshipTypeId: Int = 5, /// 5 - Последующий допуск
        sectorsArr: [Int] = [],
        duration: Int? = nil,
        simulatorCheckDate: Date? = nil,
        checkDate: Date? = nil,
        boardCheckDate: Date? = nil,
        mordersArr: [Int] = [],
        note: String? = nil
    ) {
        self.id = id
        self.planning = planning
        self.personId = personId
        self.internshipTypeId = internshipTypeId
        self.sectorsArr = sectorsArr
        self.duration = duration
        self.simulatorCheckDate = simulatorCheckDate
        self.checkDate = checkDate
        self.boardCheckDate = boardCheckDate
        self.mordersArr = mordersArr
        self.note = note
    }
}

// MARK: - Additional properties

public extension Internship {
    enum Status: String, Equatable, CaseIterable, Identifiable {
        case planning
        case pending
        case completed
        case all
        
        public var ruLabel: String {
            switch self {
            case .planning:  return "Планируется"
            case .pending:   return "Действующая"
            case .completed: return "Завершена"
            case .all:       return "Все стажировки"
            }
        }
        
        public var color: Color {
            switch self {
            case .planning:  return .green
            case .pending:   return .blue
            case .completed: return .orange
            case .all:       return Color.red
            }
        }
        
        public var id: String {
            return self.rawValue
        }
        
//        public var id: String { UUID().uuidString }
//        public var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    }
    
    var status: Status {
        if planning {
            return .planning
        } else {
            return InternshipCadenceModel.shared.getInternshipStatus(for: self)
        }
    }
}

// MARK: - Internship samples

#if DEBUG
public extension Internship {
    static let example = samples[0]
    
    static let samples = [
        Internship(
            id: 1,
            planning: true,
            personId: 2028,
            internshipTypeId: 1,
            sectorsArr: [],
            duration: 0,
            simulatorCheckDate: Date(),
            checkDate: Date(),
            boardCheckDate: Date(),
            mordersArr: [Morder.example.id],
            note: "TESTING"
        )
    ]
}
#endif
