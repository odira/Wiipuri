//
//  TableView.swift
//  WiiUnitMac
//
//  Created by Wiipuri Developer on 31.10.2024.
//

import SwiftUI

struct TableView: View {
    @EnvironmentObject var unitModel: UnitModel
    
    var filteredUnits: [Unit] {
        unitModel.units
    }
    
    var body: some View {
        
        ZStack {
            if unitModel.isFetching {
                ProgressView("Loading...")
            } else {
                Table(filteredUnits) {
                    TableColumn(Text("ATC Unit"), value: \.unit)
                }
            }
        }
        .task {
            await unitModel.fetch()
        }
        
    }
}

#Preview {
    TableView()
        .environmentObject(UnitModel.example)
}
