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
        VStack(spacing: 10) {
            headerSection
            textBodyText
        }
        .padding()
    }
    
    
    @ViewBuilder
    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text("ОТПРАВЛЕНО")
                    .bold()
                
                HStack {
                    if let recvLetterDate = history.recvLetterDate {
                        Text(dateFormatter.string(from: recvLetterDate))
                    } else {
                        Text("Дата")
                    }
                    if let sendLetterNum = history.sendLetterNum {
                        Text(sendLetterNum)
                            .font(.footnote)
                            .padding(5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(.clear)
                                    .stroke(Color.blue, lineWidth: 1)
                            }
                    } else {
                        Text("UNDEFINED")
                            .font(.footnote)
                            .padding(5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(.clear)
                                    .stroke(Color.blue, lineWidth: 1)
                            }
                    }
                }
                HStack {
                    if let sendManufacturerId = history.sendManufacturerId {
                        Text("send Manufacturer Id: \(sendManufacturerId)")
                    }
                    if let sendUnitId = history.sendUnitId {
                        Text("send Unit Id: \(sendUnitId)")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .fill(.clear)
                    .stroke(Color.blue, lineWidth: 1)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(dateFormatter.string(from: history.date))
                    .foregroundStyle(.blue)
                    .font(.title3)
                    .bold()
                    .background(.clear)
                    .padding(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.clear)
                            .stroke(Color.blue, lineWidth: 1)
                    }
                VStack(spacing: 2) {
                    Image(systemName: "figure.stand.line.dotted.figure.stand")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }

            
            VStack(alignment: .leading, spacing: 5) {
                Text("ПОЛУЧЕНО")
                    .bold()
                
                HStack {
                    if let recvLetterDate = history.recvLetterDate {
                        Text(dateFormatter.string(from: recvLetterDate))
                    } else {
                        Text("Дата")
                    }
                    if let recvLetterNum = history.recvLetterNum {
                        Text(recvLetterNum)
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
                }
                HStack {
                    if let recvManufacturerId = history.recvManufacturerId {
                        Text("send Manufacturer Id: \(recvManufacturerId)")
                    }
                    if let recvUnitId = history.recvUnitId {
                        Text("send Unit Id: \(recvUnitId)")
                    }
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
        
        VStack(alignment: .leading) {
            if let answerTo = history.answerTo {
                Text("Answer to: \(answerTo)")
            }
            if let ref = history.ref {
                Text("Reference to: \(ref)")
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
    
    
    @ViewBuilder
    private var textBodyText: some View {
        VStack {
            Text(history.history)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(.clear)
                        .stroke(Color.blue, lineWidth: 1)
                }
            
            Text(history.note ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
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
