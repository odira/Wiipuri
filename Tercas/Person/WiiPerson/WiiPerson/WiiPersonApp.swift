import SwiftUI
import WiiKit

@main
struct WiiPersonApp: App {
    @StateObject var personModel = PersonModel()
    @StateObject var positionModel = PositionModel()
    @StateObject var sectorPoolModel = SectorPoolModel()
    @StateObject var sectorModel = SectorModel()
    
    @StateObject var personFilters = PersonFilters()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(personModel)
                .environmentObject(positionModel)
                .environmentObject(sectorPoolModel)
                .environmentObject(sectorModel)
                .environmentObject(personFilters)
        }
    }
}
