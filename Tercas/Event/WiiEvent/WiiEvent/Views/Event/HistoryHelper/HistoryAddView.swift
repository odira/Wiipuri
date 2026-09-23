//
//  HistorySheetAdd.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 11.09.2024.
//

import SwiftUI

struct HistoryAddView: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var historyModel: HistoryModel
    
    let eventId: Int
    
    @State private var date: Date = Date.now
    @State private var history: String = ""
    @State private var answerTo: String? = nil
    @State private var ref: String? = nil
    @State private var note: String? = nil
    @State private var recvLetterNum: String? = nil
    @State private var recvLetterDate: Date? = Date.now
    @State private var recvManufacturerId: Int? = nil
    @State private var recvUnitId: Int? = nil
    @State private var sendLetterNum: String? = nil
    @State private var sendLetterDate: Date? = Date.now
    @State private var sendManufacturerId: Int? = nil
    @State private var sendUnitId: Int? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                HistoryFieldsEditor(
                    date: $date,
                    history: $history,
                    answerTo: $answerTo,
                    ref: $ref,
                    note: $note,
                    recvLetterNum: $recvLetterNum,
                    recvLetterDate: $recvLetterDate,
                    recvManufacturerId: $recvManufacturerId,
                    recvUnitId: $recvUnitId,
                    sendLetterNum: $sendLetterNum,
                    sendLetterDate: $sendLetterDate,
                    sendManufacturerId: $sendManufacturerId,
                    sendUnitId: $sendUnitId
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        role: .confirm,
                        action: {
                            
                            Task {
                                await historyModel.sqlINSERT(
                                    eventID: self.eventId,
                                    date: self.date,
                                    history: self.history,
                                    answerTo: self.answerTo,
                                    ref: self.ref,
                                    note: self.note,
                                    recvLetterNum: self.recvLetterNum,
                                    recvLetterDate: self.recvLetterDate,
                                    recvManufacturerId: self.recvManufacturerId,
                                    recvUnitId: self.recvUnitId,
                                    sendLetterNum: self.sendLetterNum,
                                    sendLetterDate: self.sendLetterDate,
                                    sendManufacturerId: self.sendManufacturerId,
                                    sendUnitId: self.sendUnitId
                                )
                            }
                            dismiss()
                            
                        }, label: {
                            Text("Save")
                        })
                }
            }
        }
    }
}


#Preview {
    HistoryAddView(eventId: Event.example.id)
        .environmentObject(HistoryModel.example)
}
