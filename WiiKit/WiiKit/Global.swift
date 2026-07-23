import Foundation
import Combine

public class Global: ObservableObject {
    // MARK: - Properties
    
    @Published public var shiftNum: Int
    @Published public var month: Date = Date.now /// Current month property
    @Published public var itemSize: CGFloat = 0
    
//    public var startInterval: Date {
//        Calendar.current.extendedMonthInterval(in: self.month)!.start
//    }
//    public var endInterval: Date {
//        Calendar.current.extendedMonthInterval(in: self.month)!.end
//    }
    @Published public var startInterval: Date = Date.now
    @Published public var endInterval: Date = Date.now
    
    // MARK: - Shared Initializing
    
    public static let shared = Global()
    
    // MARK: - Initializing
    
    init(shiftNum: Int = 6, month: Date = Date.now, itemSize: CGFloat = 0) {
        self.shiftNum = shiftNum
        self.itemSize = itemSize
        
        setCurrentMonth()
    }
    
    // MARK: - Additional Functions
    
    public func setCurrentMonth() {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        components.day = 1
        self.month = Calendar.current.date(from: components) ?? Date.now
        
        startInterval = Calendar.current.extendedMonthInterval(in: self.month)!.start
        endInterval = Calendar.current.extendedMonthInterval(in: self.month)!.end
    }
    
    public func getYear() -> Int {
        let yearComponent = Calendar.current.dateComponents([.year], from: self.month)
        return yearComponent.year!
    }
    
    public func addingYears(_ years: Int) {
        if let date = Calendar.current.date(byAdding: .year, value: years, to: self.month) {
            self.month = date
            
            startInterval = Calendar.current.extendedMonthInterval(in: self.month)!.start
            endInterval = Calendar.current.extendedMonthInterval(in: self.month)!.end
        }
    }
    
    public func addingMonths(_ months: Int) {
        if let date = Calendar.current.date(byAdding: .month, value: months, to: self.month) {
            self.month = date
            
            startInterval = Calendar.current.extendedMonthInterval(in: self.month)!.start
            endInterval = Calendar.current.extendedMonthInterval(in: self.month)!.end
        }
    }
    
    public func changeShiftNumber(by step: Int) {
        shiftNum += step
        if shiftNum == 7 { shiftNum = 1 }
        if shiftNum == 0 { shiftNum = 6 }
    }
}
