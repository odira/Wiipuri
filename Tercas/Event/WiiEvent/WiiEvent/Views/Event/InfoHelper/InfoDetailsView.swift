//
//  InfoDetails.swift
//  WiiEvent
//
//  Created by Vladimir Ilin on 20.11.2025.
//

import SwiftUI

struct InfoDetailsView: View {
    @Environment(\.openWindow) var openWindow
    
    @EnvironmentObject var infoModel: InfoModel
    
    let info: Info
    
    init(for info: Info) {
        self.info = info
    }
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(info.date, style: .date)
                    .font(.title2)
                    .foregroundStyle(.blue)
                
                ScrollView {
                    Text(LocalizedStringKey(info.info))
                        .padding()
                        .background(.background)
                }
            }
            
        }
    }
}

#Preview {
    InfoDetailsView(for: Info.example)
        .environmentObject(InfoModel.example)
}
