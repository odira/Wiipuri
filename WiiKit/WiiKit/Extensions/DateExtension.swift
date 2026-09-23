import Foundation

public extension Date {
    
    func getDay() -> Int {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day!
    }
    
    //    func weekDaysSymbols() -> [String] {
//            let weekDays = shortWeekdaySymbols
    //        let sortedWeekDays = Array(weekDays[firstWeekday - 1 ..< shortWeekdaySymbols.count] + weekDays[0 ..< firstWeekday - 1])
    //        return sortedWeekDays.map { $0.uppercased() }
    //    }
    
    func getWeekDay() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = .init(identifier: "ru")
        let weekDay = dateFormatter.string(from: self)
        return weekDay
    }
    
    func isDayOff() -> Bool {
        let firstWeekDay = Calendar.current.firstWeekday
        let gregorianFirstWeekDay = Calendar(identifier: .gregorian).firstWeekday
        let componentToSubtract = -(firstWeekDay - gregorianFirstWeekDay)
        let newFirstWeekDay = firstWeekDay + componentToSubtract
        
        let weekDay = Calendar.current.component(.weekday, from: self)

        if weekDay == newFirstWeekDay + 6 || weekDay == newFirstWeekDay  { return true }
        else { return false }
    }
    
//    func isEntEvent() -> Bool {
//        let
//    }
    
//    func isHoliday() -> Bool {
//            if let holiday = .filter({ $0.id == id }).first {
//                return activity
//            }
//
//    }
    

    //    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
    //        self.isDate(self, equalTo: date, toGranularity: component)
    //    }
    //
    //    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    //    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    //    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    //
    //    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    //
    //    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    //    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    //    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
    //
    //    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    //    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    //    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
    //
    //    var isInTheFuture: Bool { self > Date() }
    //    var isInThePast:   Bool { self < Date() }
    
    func shiftIsWorking(shift: Int) -> Bool {
        var componentsSix = DateComponents()
        componentsSix.day = 19
        componentsSix.month = 3
        componentsSix.year = 2000
        let dateSix = Calendar.current.date(from: componentsSix)!
        
        let numberOfDays = Calendar.current.dateComponents([.day], from: self, to: dateSix)
        
        if let num = numberOfDays.day {
            let mod = (abs(num) + shift) % 6
            return (mod == 1 || mod == 2 || mod == 3 || mod == 4) ? true : false
        }
        else { return false }
    }
    
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }
}
