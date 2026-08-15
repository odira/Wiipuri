//
//  ContentView.swift
//  XXX
//
//  Created by Wiipuri Developer on 25.12.2025.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .topTrailing) {
                blueRectangle
                yellowCircle
                    .alignmentGuide(.top) { $0[.top] + $0.height / 2 }
                    .alignmentGuide(.trailing) { $0[.trailing] - $0.width / 2 }
            }
            yellowCircle
                .alignmentGuide(.bottom) { $0[.bottom] - $0.height / 2 }
                .alignmentGuide(.leading) { $0[.leading] + $0.width / 2 }
        }
        .border(.red, width: 2 )
    }
}

#Preview {
    ContentView()
}

var blueRectangle: some View {
    Rectangle()
        .foregroundStyle(.blue.gradient)
        .frame(width: 200, height: 200)
}

var yellowCircle: some View {
    Circle()
        .foregroundStyle(.yellow.gradient)
        .frame(width: 60, height: 60)
}
