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
        VStack(spacing: 20) {
            dateSection
            lettersSection
            historyText
        }
        .padding()
    }
    
    
    @ViewBuilder
    private var dateSection: some View {
        HStack {
            Text(dateFormatter.string(from: history.date))
                .foregroundStyle(.blue)
                .font(.title2)
                .bold()
                .background(.clear)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(.clear)
                        .stroke(Color.blue, lineWidth: 1)
                }
        }
    }
    
    
    @ViewBuilder
    private var lettersSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Отправлено")
                    .bold()
                HStack {
                    Text("письмо")
                        .font(.footnote)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                    Text(dateFormatter.string(from: Date.now))
                }
                HStack {
                    Text("отправитель")
                        .font(.footnote)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                    Text("ОТПРАВИТЕЛЬ")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .fill(.clear)
                    .stroke(Color.blue, lineWidth: 1)
            }
            
            VStack {
                Image(systemName: "figure.stand.line.dotted.figure.stand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Image(systemName: "arrow.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }

            
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
                    } else {
                        Text("Письмо")
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
                    } else {
                        Text("Дата")
                    }
                }
                HStack {
                    Text("получатель")
                        .font(.footnote)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                    Text("ПОЛУЧАТЕЛЬ")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .fill(.clear)
                    .stroke(Color.blue, lineWidth: 1)
            }

        }
    }
    
    
    @ViewBuilder
    private var historyText: some View {
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
}

#Preview(traits: .fixedLayout(width: 900, height: 300)) {
    HistoryRow(history: History.example)
        .environmentObject(EventModel.example)
        .environmentObject(HistoryModel.example)
}
