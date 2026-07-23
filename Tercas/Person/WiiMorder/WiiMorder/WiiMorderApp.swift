import SwiftUI
import WiiKit

@main
struct WiiMorderApp: App {
    @StateObject var morderModel = MorderModel()
    @StateObject var personModel = PersonModel()
    @StateObject var positionModel = PositionModel()
    @StateObject var sectorPoolModel = SectorPoolModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(morderModel)
                .environmentObject(personModel)
                .environmentObject(positionModel)
                .environmentObject(sectorPoolModel)
        }
    }
}
