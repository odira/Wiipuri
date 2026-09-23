import SwiftUI
import WiiKit

@main
struct WiiShiftApp: App {
    @StateObject var personModel = PersonModel()
    @StateObject var positionModel = PositionModel()
    @StateObject var sectorPoolModel = SectorPoolModel()
    @StateObject var sectorModel = SectorModel()
    
    @StateObject var teamViewModel = TeamViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(personModel)
                .environmentObject(positionModel)
                .environmentObject(sectorPoolModel)
                .environmentObject(sectorModel)
                .environmentObject(teamViewModel)
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
