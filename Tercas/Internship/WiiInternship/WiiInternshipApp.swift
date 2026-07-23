import SwiftUI
import WiiKit

@main
struct WiInternshipApp: App {
    @StateObject var internshipModel = InternshipModel()
    @StateObject var internshipTypeModel = InternshipTypeModel()
    @StateObject var internshipCadenceModel = InternshipCadenceModel()
    @StateObject var personModel = PersonModel()
    @StateObject var positionModel = PositionModel()
    @StateObject var sectorModel = SectorModel()
    @StateObject var sectorPoolModel = SectorPoolModel()
    @StateObject var morderModel = MorderModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(internshipModel)
                .environmentObject(internshipTypeModel)
                .environmentObject(internshipCadenceModel)
                .environmentObject(personModel)
                .environmentObject(positionModel)
                .environmentObject(sectorModel)
                .environmentObject(sectorPoolModel)
                .environmentObject(morderModel)
        }
    }
}
