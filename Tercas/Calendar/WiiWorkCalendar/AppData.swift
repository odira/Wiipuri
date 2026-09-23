import Foundation
import SwiftUI

class Data: ObservableObject {
    @Published var shiftNum: Int
    @Published var month: Date = Date.now
    @Published var itemSize: CGFloat = 0
    
    static let shared = Data()
    
    init() {
        shiftNum = 6
        reloadDate()
    }
    
    func reloadDate() {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        components.day = 1
        self.month = Calendar.current.date(from: components) ?? Date.now
    }
    
    func getYear() -> Int {
        let yearComponent = Calendar.current.dateComponents([.year], from: self.month)
        return yearComponent.year!
    }
    
    func addingYears(_ years: Int) {
        if let date = Calendar.current.date(byAdding: .year, value: years, to: self.month) {
            self.month = date
        }
    }
    
    func addingMonths(_ months: Int) {
        if let date = Calendar.current.date(byAdding: .month, value: months, to: self.month) {
            self.month = date
        }
    }
    
    func changeShiftNumber(by step: Int) {
        shiftNum += step
        if shiftNum == 7 { shiftNum = 1}
        if shiftNum == 0 { shiftNum = 6}
    }
}
