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

//    @State private var date: Date = Date.now
//    @State private var history: String = ""
//    @State private var answerTo: String? = nil
//    @State private var ref: String? = nil
//    @State private var note: String? = nil
//    @State private var recvLetterNum: String? = nil
//    @State private var recvLetterDate: Date? = Date.now
//    @State private var recvManufacturerId: Int? = nil
//    @State private var recvUnitId: Int? = nil
//    @State private var sendLetterNum: String? = nil
//    @State private var sendLetterDate: Date? = Date.now
//    @State private var sendManufacturerId: Int? = nil
//    @State private var sendUnitId: Int? = nil
    
    @State var hist: History

    
    var body: some View {
//        NavigationStack {
            VStack {
                HistoryFieldsEditor(
                    date: $hist.date,
                    history: $hist.history,
                    answerTo: $hist.answerTo,
                    ref: $hist.ref,
                    note: $hist.note,
                    recvLetterNum: $hist.recvLetterNum,
                    recvLetterDate: $hist.recvLetterDate,
                    recvManufacturerId: $hist.recvManufacturerId,
                    recvUnitId: $hist.recvUnitId,
                    sendLetterNum: $hist.sendLetterNum,
                    sendLetterDate: $hist.sendLetterDate,
                    sendManufacturerId: $hist.sendManufacturerId,
                    sendUnitId: $hist.sendUnitId
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        role: .confirm,
                        action: {
                            Task {
                                await historyModel.sqlUPDATE(
                                    id: hist.id,
                                    date: hist.date,
                                    history: hist.history,
                                    answerTo: hist.answerTo,
                                    ref: hist.ref,
                                    note: hist.note,
                                    recvLetterNum: hist.recvLetterNum,
                                    recvLetterDate: hist.recvLetterDate,
                                    recvManufacturerId: hist.recvManufacturerId,
                                    recvUnitId: hist.recvUnitId,
                                    sendLetterNum: hist.sendLetterNum,
                                    sendLetterDate: hist.sendLetterDate,
                                    sendManufacturerId: hist.sendManufacturerId,
                                    sendUnitId: hist.sendUnitId
                                )
//                                await historyModel.fetch()
                            }
                            dismiss()
                        }, label: {
                            Text("Save")
                        })
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
//        }
    }
}

#Preview {
    HistoryEditView(hist: History.example)
        .environmentObject(HistoryModel.example)
}
