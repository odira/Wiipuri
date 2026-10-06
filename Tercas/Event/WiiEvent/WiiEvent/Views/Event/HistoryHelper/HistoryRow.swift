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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            dateBody
            headerSection
            historySection
        }
        .padding(10)
    }
    
    
    @ViewBuilder
    private var headerSection: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                sendLetterSection
                iconBody
                recvLetterSection
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
                    .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
            }
        }
    }
    
    @ViewBuilder
    private var sendLetterSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("ОТПРАВЛЕНО")
                .bold()
            
            HStack {
                if let sendLetterNum = history.sendLetterNum {
                    Text(sendLetterNum)
                        .font(.footnote)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                        }
                } else {
                    Text("UNDEFINED")
                        .font(.footnote)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                        }
                }
                if let recvLetterDate = history.recvLetterDate {
                    Text(DateFormatter.normalDate.string(from: recvLetterDate))
                } else {
                    Text("Дата")
                }
            }
            HStack {
                if let sendManufacturerId = history.sendManufacturerId {
                    Text("send Manufacturer Id: \(sendManufacturerId)")
                }  else if let sendUnitId = history.sendUnitId {
                    Text("send Unit Id: \(sendUnitId)")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(.clear)
                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
        }
    }
    
    @ViewBuilder
    private var recvLetterSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("ПОЛУЧЕНО")
                .bold()
            
            HStack {
                if let recvLetterDate = history.recvLetterDate {
                    Text(DateFormatter.normalDate.string(from: recvLetterDate))
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
                                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                        }
                } else {
                    Text("Письмо")
                        .font(.footnote)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.clear)
                                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                        }
                }
            }
            HStack {
                if let recvManufacturerId = history.recvManufacturerId {
                    Text("send Manufacturer Id: \(recvManufacturerId)")
                } else if let recvUnitId = history.recvUnitId {
                    Text("send Unit Id: \(recvUnitId)")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(.clear)
                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
        }
    }
    
    @ViewBuilder
    private var historySection: some View {
        VStack {
            Text(history.history)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(.clear)
                        .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                }
            
            Text(history.note ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(.clear)
                        .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var dateBody: some View {
        Text(DateFormatter.normalDate.string(from: history.date))
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
    
    @ViewBuilder
    private var iconBody: some View {
            Image(systemName: "shift")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .rotationEffect(.degrees(90))
    }
}

#Preview(traits: .fixedLayout(width: 900, height: 300)) {
    HistoryRow(history: History.example)
        .environmentObject(EventModel.example)
        .environmentObject(HistoryModel.example)
}
