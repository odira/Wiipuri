//
//  HistoryRow.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 15.06.2025.
//

import SwiftUI

struct HistoryRow: View {
    @EnvironmentObject var historyModel: HistoryModel

    let history: History
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    
    var body: some View {
        VStack {
            HStack {
                Text(dateFormatter.string(from: history.date))
                    .foregroundStyle(.blue)
                    .bold()
                    .background(.clear)
                    .padding(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.clear)
                            .stroke(Color.blue, lineWidth: 1)
                    }
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Отправлено")
                        .bold()
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Получено")
                        .bold()
                    HStack {
                        if let letterNumReceiver = history.letterNumReceiver {
                            Text(letterNumReceiver)
                                .font(.footnote)
                                .padding(5)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .fill(.clear)
                                        .stroke(Color.blue, lineWidth: 1)
                                }
                        }
                        if let letterDateReceiver = history.letterDateReceiver {
                            Text(dateFormatter.string(from: letterDateReceiver))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack {
                Text(history.history)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.clear)
                            .stroke(Color.blue, lineWidth: 1)
                    }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview(traits: .fixedLayout(width: 900, height: 300)) {
    HistoryRow(history: History.example)
        .environmentObject(EventModel.example)
        .environmentObject(HistoryModel.example)
}
