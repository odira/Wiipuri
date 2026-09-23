import SwiftUI
import WiiKit

@main
struct PeriodApp: App {
    // MARK: Source of truth for models
    @StateObject var personModel = PersonModel()
    @StateObject var positionModel = PositionModel()
    @StateObject var periodModel = PeriodModel()
    @StateObject var activityModel = ActivityModel()
    @StateObject var personFilters = PersonFilters()
    @StateObject var sectorPoolModel = SectorPoolModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(personModel)
                .environmentObject(positionModel)
                .environmentObject(periodModel)
                .environmentObject(activityModel)
                .environmentObject(personFilters)
                .environmentObject(sectorPoolModel)
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
