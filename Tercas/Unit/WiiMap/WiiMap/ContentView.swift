//
//  ContentView.swift
//  WiiMap
//
//  Created by Wiipuri Developer on 25.08.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        MapView()
            .mapStyle(.hybrid(elevation: .realistic))
    }
}

#Preview {
    ContentView()
}
