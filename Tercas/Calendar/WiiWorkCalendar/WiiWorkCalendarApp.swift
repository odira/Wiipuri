import SwiftUI
import WiiKit

@main
struct WorkingCalendarApp: App {
    @StateObject var personModel = PersonModel()
    @StateObject var positionModel = PositionModel()
    @StateObject var sectorPoolModel = SectorPoolModel()
    @StateObject var periodModel = PeriodModel()
    @StateObject var activityModel = ActivityModel()
    @StateObject var holidayModel = HolidayModel()
    @StateObject var entEventsModel = EntEventModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(personModel)
                .environmentObject(positionModel)
                .environmentObject(sectorPoolModel)
                .environmentObject(periodModel)
                .environmentObject(activityModel)
                .environmentObject(holidayModel)
                .environmentObject(entEventsModel)
                .environment(
                    \.calendar, {
                        var calendar = Calendar(identifier: .gregorian)
                        calendar.firstWeekday = 2
                        calendar.locale = Locale(identifier: "ru_RU")
                        return calendar
                    }()
                )
        }
    }
}
