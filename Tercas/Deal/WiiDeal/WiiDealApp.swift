//
//  WiiDealApp.swift
//  WiiDeal
//
//  Created by Wiipuri Developer on 05.01.2025.
//

import SwiftUI

@main
struct WiiDealApp: App {
    @StateObject var dealViewModel = DealViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dealViewModel)
        }
    }
}
