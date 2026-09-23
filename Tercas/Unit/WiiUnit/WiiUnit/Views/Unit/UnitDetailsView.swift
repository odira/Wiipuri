//
//  UnitDetailsView.swift
//  WiiUnit
//
//  Created by Wiipuri Developer on 27.08.2024.
//

import SwiftUI

struct UnitDetailsView: View {
    let unit: Unit
    
    var body: some View {
        Form {
            
            Section {
                Text("ФГУП Госкорпорация по ОрВД")
                Text("Филиал Аэронавигация Юга")
                Text(unit.unit!)
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Section("Объект") {
//                LabeledContent("Тип объекта", value: unit.typeAbbr ?? "Not defined")
                Text(unit.type!)
                    .font(.caption)
//                if let typeNote = unit.typeNote {
//                    Text(typeNote)
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
            }
            
            Section("Местоположение") {
                LabeledContent("Город", value: unit.city ?? "Not defined")
                LabeledContent("Аэродром", value: String("\(unit.adId ?? 0)"))
            }
            
        } // Form
    } // body
}

#Preview {
    UnitDetailsView(unit: Unit.example)
}
