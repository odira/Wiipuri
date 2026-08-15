//
//  ContentView.swift
//  WiiUnit
//
//  Created by Wiipuri Developer on 27.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    private enum TabValue {
        case list
        case category
        case group
    }
    @State private var selectedTab: TabValue = .list
    
    var body: some View {

            TabView(selection: $selectedTab) {
                Tab("List", systemImage: "list.bullet", value: .list) {
//                    #if os(iOS)
//                        UnitListView()
//                    #elseif os(macOS)
//                        TableView()
//                    #endif
                    UnitListView()
                }
                Tab("Category", systemImage: "star", value: .category) {
                    EmptyView()
                }
                Tab("Group", systemImage: "rectangle.3.group.fill", value: .group) {
                    EmptyView()
                }
            }
        
    } // body
}

#Preview {
    ContentView()
}
