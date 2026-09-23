import Foundation
import SwiftUI

public extension String {
    
    func toDateInterval() -> DateInterval? {
        var tmpStr = self
        tmpStr.removeFirst()
        tmpStr.removeLast()
        
        let dateArray = tmpStr.components(separatedBy: ",")
        var dateInterval = DateInterval()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if dateArray[0] == "" { return nil }
        if dateArray[1] == "" { return nil }
        
        let startDate = dateFormatter.date(from: dateArray[0])!
        let endDate = dateFormatter.date(from: dateArray[1])!
        let newEndDate = Calendar.current.date(byAdding: .day, value: -1, to: endDate)!

        dateInterval = DateInterval(start: startDate, end: newEndDate)
        return dateInterval
    }
    
    func toColor() -> Color {
        #if os(iOS)
            return Color(UIColor.init(hexString: self))
        #elseif os(macOS)
            return Color(NSColor.init(hexString: self))
        #endif
    }
    
    func toIntArray() -> [Int] {
        var tmpStr = self
        if tmpStr.isEmpty {
            return []
        }
        
        tmpStr.removeFirst()
        tmpStr.removeLast()
        
        let array = tmpStr.components(separatedBy: ",")
        let intArray = array.compactMap { Int($0) }
        
        return intArray
    }
    
}
