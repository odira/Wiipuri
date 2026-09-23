//
//  UnitListView.swift
//  WiiUnit
//
//  Created by Wiipuri Developer on 27.08.2024.
//

import SwiftUI

struct UnitListView: View {
    @EnvironmentObject var unitModel: UnitModel
    
    private var filteredUnits: [Unit] {
        unitModel.units
            .filter { unit in
                if !searchText.isEmpty {
//                    return unit.unit.contains( searchText )
                    return true
                } else {
                    return true
                }
            }
        
    }
    
    @State private var searchText: String = ""
    
    var body: some View {
       
//        NavigationStack {
        
            ZStack {
                if unitModel.isFetching {
                    ProgressView("Loading...")
                } else {
                    
                    List(filteredUnits) { unit in
                        NavigationLink(destination: {
                            UnitDetailsView(unit: unit)
                                #if os(iOS)
                                .toolbar(.hidden, for: .tabBar)
                                #endif
//                                .navigationTitle(unit.unit)
//                                .navigationBarTitleDisplayMode(.inline)
                        }, label: {
                            Text(unit.unit!)
                        })
                    }
                    .listStyle(.plain)
                    #if os(iOS)
                    .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Поиск по объекту...")
                    #endif
                    .refreshable {
                        await unitModel.fetch()
                    }
                    
                }
            }
//            #if os(iOS)
//            .navigationBarTitle("Перечень объектов")
//            #endif
            .task {
                await unitModel.fetch()
            }
            
//        }
        
    }
}

#Preview {
    UnitListView()
        .environmentObject(UnitModel(units: [Unit.example]))
}
