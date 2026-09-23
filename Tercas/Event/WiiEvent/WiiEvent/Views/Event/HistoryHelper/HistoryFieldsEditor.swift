//
//  HistoryFieldsEditor.swift
//  WiiEventMac
//
//  Created by Wiipuri Developer on 18.06.2025.
//

import SwiftUI

struct HistoryFieldsEditor: View {
    @Binding var date: Date
    @Binding var history: String
    @Binding var answerTo: String?
    @Binding var ref: String?
    @Binding var note: String?
    @Binding var recvLetterNum: String?
    @Binding var recvLetterDate: Date?
    @Binding var recvManufacturerId: Int?
    @Binding var recvUnitId: Int?
    @Binding var sendLetterNum: String?
    @Binding var sendLetterDate: Date?
    @Binding var sendManufacturerId: Int?
    @Binding var sendUnitId: Int?
    
//    init(
//        date: Date,
//        history: String,
//        answerTo: String?,
//        ref: String?,
//        note: String?,
//        recvLetterNum: String?,
//        recvLetterDate: Date?,
//        recvManufacturerId: Int?,
//        recvUnitId: Int?,
//        sendLetterNum: String?,
//        sendLetterDate: Date?,
//        sendManufacturerId: Int?,
//        sendUnitId: Int?
//    ) {
//        self.date = date
//        self.history = history
//        self.answerTo = answerTo
//        self.ref = ref
//        self.note = note
//        self.recvLetterNum = recvLetterNum
//        self.recvLetterDate = recvLetterDate
//        self.recvManufacturerId = recvManufacturerId
//        self.recvUnitId = recvUnitId
//        self.sendLetterNum = sendLetterNum
//        self.sendLetterDate = sendLetterDate
//        self.sendManufacturerId = sendManufacturerId
//        self.sendUnitId = sendUnitId
//    }
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    DatePicker(
                        "Select a Date",
                        selection: Binding(
                            get: { self.sendLetterDate ?? Date() },
                            set: { self.sendLetterDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .contentShape(Rectangle())
                    .font(.callout)
                    
                    TextField(
                        "Enter send letter number",
                        text: Binding(
                            get: { self.sendLetterNum ?? "" },
                            set: { self.sendLetterNum = $0 }
                        )
                    )
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
                    
                    TextField(
                        "Enter send manufacturer id",
                        text: Binding(
                            get: {
                                if let id = self.sendManufacturerId {
                                    return String(id)
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                if newValue.isEmpty {
                                    self.sendManufacturerId = nil
                                } else if let id = Int(newValue) {
                                    self.sendManufacturerId = id
                                }
                            }
                        )
                    )
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
                    
                    TextField(
                        "Enter send unit id",
                        text: Binding(
                            get: {
                                if let id = self.sendUnitId {
                                    return String(id)
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                if newValue.isEmpty {
                                    self.sendUnitId = nil
                                } else if let id = Int(newValue) {
                                    self.sendUnitId = id
                                }
                            }
                        )
                    )
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
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
                .padding(20)
                
                VStack {
                    DatePicker(
                        "Select a Date",
                        selection: Binding(
                            get: { self.recvLetterDate ?? Date() },
                            set: { self.recvLetterDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .contentShape(Rectangle())
                    .font(.callout)
                    
                    TextField(
                        "Enter receiver letter number",
                        text: Binding(
                            get: { self.recvLetterNum ?? "" },
                            set: { self.recvLetterNum = $0 }
                        )
                    )
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
                    
                    TextField(
                        "Enter recv manufacturer id",
                        text: Binding(
                            get: {
                                if let id = self.recvManufacturerId {
                                    return String(id)
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                if newValue.isEmpty {
                                    self.recvManufacturerId = nil
                                } else if let id = Int(newValue) {
                                    self.recvManufacturerId = id
                                }
                            }
                        )
                    )
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
                    
                    TextField(
                        "Enter recv unit id",
                        text: Binding(
                            get: {
                                if let id = self.recvUnitId {
                                    return String(id)
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                if newValue.isEmpty {
                                    self.recvUnitId = nil
                                } else if let id = Int(newValue) {
                                    self.recvUnitId = id
                                }
                            }
                        )
                    )
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
                }
            }
            
            Divider()
                .overlay(.primary)
                .padding()
            
            HStack {
                TextField(
                    "Enter answerTo",
                    text: Binding(
                        get: { self.answerTo ?? "" },
                        set: { self.answerTo = $0 }
                    )
                )
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blue, lineWidth: 1)
                }
                
                TextField(
                    "Enter reference",
                    text: Binding(
                        get: { self.ref ?? "" },
                        set: { self.ref = $0 }
                    )
                )
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blue, lineWidth: 1)
                }
            }
            
            Divider()
                .overlay(.primary)
                .padding()
            
            DatePicker(
                "Select a Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.compact)
            .contentShape(Rectangle())
            
            VStack {
                TextEditor(text: $history)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 1)
                    }
                    .frame(maxHeight: .infinity)
                
                TextEditor(
                    text: Binding(
                        get: { self.note ?? "" },
                        set: { self.note = $0 }
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blue, lineWidth: 1)
                }
                .frame(height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    HistoryFieldsEditor(
        date: .constant(History.example.date),
        history: .constant(History.example.history),
        answerTo: .constant(History.example.answerTo),
        ref: .constant(History.example.ref),
        note: .constant(History.example.note),
        recvLetterNum: .constant(History.example.recvLetterNum),
        recvLetterDate: .constant(History.example.recvLetterDate),
        recvManufacturerId: .constant(History.example.recvManufacturerId),
        recvUnitId: .constant(History.example.recvUnitId),
        sendLetterNum: .constant(History.example.sendLetterNum),
        sendLetterDate: .constant(History.example.sendLetterDate),
        sendManufacturerId: .constant(History.example.sendManufacturerId),
        sendUnitId: .constant(History.example.sendUnitId)
    )
}
