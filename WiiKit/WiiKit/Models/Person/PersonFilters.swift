import Foundation
import Combine

public enum PersonValid {
    case all
    case valid
    case invalid
}

public class PersonFilters: ObservableObject {
    @Published public var byValid: PersonValid = .all
    @Published public var byName: String = ""
    @Published public var byMiddlename: String = ""
    @Published public var bySurname: String = ""
    @Published public var byShiftNum: Int = 0
    
    public init() {
        byValid = .all
        byName = ""
        byMiddlename = ""
        bySurname = ""
        byShiftNum = 0
    }
    
    public func update() {
        byValid = .all
        byName = ""
        byMiddlename = ""
        bySurname = ""
        byShiftNum = 0
    }
}
