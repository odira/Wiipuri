import Foundation
import SwiftUI

public extension DateInterval {

    func toSQLstring() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputStr = "[" + dateFormatter.string(from: self.start) + "," + dateFormatter.string(from: self.end) + "]"
        return outputStr
    }
}
