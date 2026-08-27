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
        VStack {
            Text(info.date, style: .date)
                .font(.title2)
                .bold()
                .foregroundStyle(.blue)
            
                ScrollView(.vertical) {
                    Text(LocalizedStringKey(info.info))
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
        }
        .border(Color.gray)
        .padding()
    }
}

#Preview {
    InfoDetailsView(for: Info.example)
        .environmentObject(InfoModel.example)
}
