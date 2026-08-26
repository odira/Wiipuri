//
//  Created by Vladimir Ilin on 11.11.2023.
//

import SwiftUI

@main
struct WiiEventApp: App {
    @StateObject var eventModel = EventModel()
    @StateObject var dealModel = DealModel()
    @StateObject var planModel = PlanModel()
    @StateObject var eventModelFilter = EventModelFilter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if eventModel.isFetching {
                    SplashView()
                } else {
                     ContentView()
                        .environmentObject(eventModel)
                        .environmentObject(dealModel)
                        .environmentObject(planModel)
                        .environmentObject(eventModelFilter)
                }
            }
            .task {
                await eventModel.fetch()
                await dealModel.fetch()
                await planModel.fetch()
            }
        }  
    }
}

// MARK: - Splash View

struct SplashView: View {
    var body: some View {
        VStack {
            Image(systemName: "memorychip")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.orange)
            ProgressView("Loading data from remote database...")
                .font(.headline).bold()
                .padding()
        }
    }
}
