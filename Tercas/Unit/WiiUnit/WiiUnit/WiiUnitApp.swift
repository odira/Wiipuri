//
//  WiiUnitApp.swift
//  WiiUnit
//
//  Created by Wiipuri Developer on 27.08.2024.
//

import SwiftUI

@main
struct WiiUnitApp: App {
    @StateObject var unitModel: UnitModel = UnitModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(unitModel)
    }
}
