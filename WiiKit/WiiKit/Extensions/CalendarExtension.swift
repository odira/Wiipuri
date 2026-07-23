import Foundation

public extension Calendar {
    
    // Generate array of days for interval with define components
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        self.enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
    
    // Returns if date lays within month
    func isDateInsideMonth(_ date: Date, inside month: Date) -> Bool {
        self.isDate(date, equalTo: month, toGranularity: .month)
    }
    
    // Generate array of days for month
    func generateDatesForMonth(for month: Date) -> [Date] {
        guard
            let monthInterval = dateInterval(of: .month, for: month)
        else { return [] }
        
        return generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    // Generate array of days for extended month
    func generateDatesForExtendedMonth(for month: Date) -> [Date] {
        guard
            let monthInterval = dateInterval(of: .month, for: month)
        else { return [] }

        /// Define start and end dates of extended month interval
        let startDate = monthInterval.start.addingTimeInterval(-3 * 24 * 60 * 60)
        let endDate = startDate.addingTimeInterval(36 * 24 * 60 * 60)
        
        let extendedMonthInterval = DateInterval(start: startDate, end: endDate)
        
        return generateDates(
            inside: extendedMonthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    // Generate extended month interval
    func extendedMonthInterval(in month: Date) -> DateInterval? {
        guard
            let monthInterval = dateInterval(of: .month, for: month)
        else { return nil }

        /// Define start and end dates of extended month interval
        let startDate = monthInterval.start.addingTimeInterval(-3 * 24 * 60 * 60)
        let endDate = startDate.addingTimeInterval(36 * 24 * 60 * 60)
        
        return DateInterval(start: startDate, end: endDate)
    }
    
//    func weekDaysSymbols() -> [String] {
//        let weekDays = shortWeekdaySymbols
//        let sortedWeekDays = Array(weekDays[firstWeekday - 1 ..< shortWeekdaySymbols.count] + weekDays[0 ..< firstWeekday - 1])
//        return sortedWeekDays.map { $0.uppercased() }
//    }
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day!
    }
}
