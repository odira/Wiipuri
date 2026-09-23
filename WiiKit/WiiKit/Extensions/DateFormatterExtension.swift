import Foundation

public extension DateFormatter {
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }

    static var year: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
//    static var date: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ru")
//        formatter.dateStyle = .long
//        formatter.timeStyle = .none
//        return formatter
//    }
    
    static var planningMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    static var longDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
}
