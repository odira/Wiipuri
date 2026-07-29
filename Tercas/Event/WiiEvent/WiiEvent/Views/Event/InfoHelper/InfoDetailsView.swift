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
                
                HStack {
                    Text(info.date, style: .date)
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.glassProminent)
                
                Text(LocalizedStringKey(info.info))
                    .font(.custom("Courier", size: 16))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .fixedSize(horizontal: false, vertical: false)
                    .textEditorStyle(.plain)
                    .padding()
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(LocalizedStringKey(info.note))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .fixedSize(horizontal: false, vertical: false)
                    .textEditorStyle(.plain)
                    .padding()
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow.opacity(0.1))
        }
    }
}

#Preview {
    InfoDetailsView(for: Info.example)
        .environmentObject(InfoModel.example)
        #if os(macOS)
        .frame(width: 600, height: 800)
        #endif
}
