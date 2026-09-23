//
//  HistoryEditView.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 05.09.2024.
//

import SwiftUI

struct HistoryEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var historyModel: HistoryModel

    @State var history: History
    
    var body: some View {
        NavigationStack {
            VStack {
                HistoryFieldsEditor(
                    date: $history.date,
                    history: $history.history,
                    answerTo: $history.answerTo,
                    ref: $history.ref,
                    note: $history.note,
                    recvLetterNum: $history.recvLetterNum,
                    recvLetterDate: $history.recvLetterDate,
                    recvManufacturerId: $history.recvManufacturerId,
                    recvUnitId: $history.recvUnitId,
                    sendLetterNum: $history.sendLetterNum,
                    sendLetterDate: $history.sendLetterDate,
                    sendManufacturerId: $history.sendManufacturerId,
                    sendUnitId: $history.sendUnitId
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        Task {
//                            await historyModel.sqlUPDATE(history: history)
//                            dismiss()
//                        }
//                    }
                }
            }
        }
    }
}

#Preview {
    HistoryEditView(history: History.example)
        .environmentObject(HistoryModel.example)
}
