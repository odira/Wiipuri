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
//                HistoryFieldsEditor(
//                    history.eventID: $history.eventID,
//                    history.date: $history.date,
//                    history.history: $history.history,
//                    history.answerTo: $history.answerTo,
//                    history.ref: $history.ref,
//                    history.note: $history.note,
//                    history.recvLetterNum: $history.recvLetterNum,
//                    history.recvLetterDate: $history.recvLetterDate,
//                    history.recvManufacturerId: $history.recvManufacturerId,
//                    history.recvUnitId: $history.recvUnitId,
//                    history.sendLetterNum: $history.sendLetterNum,
//                    history.sendLetterDate: $history.sendLetterDate,
//                    history.sendManufacturerId: $history.sendManufacturerId,
//                    history.sendUnitId: $history.sendUnitId
//                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(
//                        role: .confirm,
//                        action: {
//                            Task {
//                                await historyModel.sqlUPDATE(
//                                    history.eventID: self.eventID,
//                                    history.date: self.date,
//                                    history.history: self.history,
//                                    history.answerTo: self.answerTo,
//                                    history.ref: self.ref,
//                                    history.note: self.note,
//                                    history.recvLetterNum: self.recvLetterNum,
//                                    history.recvLetterDate: self.recvLetterDate,
//                                    history.recvManufacturerId: self.recvManufacturerId,
//                                    history.recvUnitId: self.recvUnitId,
//                                    history.sendLetterNum: self.sendLetterNum,
//                                    history.sendLetterDate: self.sendLetterDate,
//                                    history.sendManufacturerId: self.sendManufacturerId,
//                                    history.sendUnitId: self.sendUnitId
//                                )
//                            }
//                            dismiss()
//                        }, label: {
//                            Text("Save")
//                        })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        role: .cancel,
                        action: {
                            dismiss()
                        }, label: {
                            Text("Close")
                        })
                }
            }
        }
    }
}

#Preview {
    HistoryEditView(history: History.example)
        .environmentObject(HistoryModel.example)
}
