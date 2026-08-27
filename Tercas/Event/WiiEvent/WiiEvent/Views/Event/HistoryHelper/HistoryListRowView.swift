//
//  HistoryRow.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 15.06.2025.
//

import SwiftUI

struct HistoryListRowView: View {
    @EnvironmentObject var historyModel: HistoryModel

    let history: History
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.3)
                .cornerRadius(10)
                
            VStack(alignment: .leading) {
                HStack {
                    Text(dateFormatter.string(from: history.date))
                        .foregroundStyle(.blue)
                        .bold()
                        .background(.clear)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                }
                
                HStack {
                    if let letterNumReceiver = history.letterNumReceiver {
                        HStack {
                            Text(letterNumReceiver)
                            Text(" от ")
                            Text(dateFormatter.string(from: history.letterDateReceiver!))
                        }
                        .font(.footnote)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                    }
                }
                
                HStack {
                    Text(history.history)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview(traits: .fixedLayout(width: 900, height: 300)) {
    HistoryListRowView(history: History.example)
        .environmentObject(EventModel.example)
        .environmentObject(HistoryModel.example)
}
