//
//  InfoFieldsEditor.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 21.10.2025.
//

import SwiftUI

struct InfoFieldsEditor: View {
    @Binding var date: Date
    @Binding var info: String
    @Binding var note: String
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        DatePicker("Select a Date", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                        
                        Spacer()
                    }
                    
                    TextEditor(text: $info)
                        .font(.custom("Courier", size: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        }
                    
                    TextEditor(text: $note)
                        .font(.custom("Courier", size: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        }
                }
                .frame(minHeight: geometry.size.height)
            }
            .padding()
        }
    }
}

#Preview {
    InfoFieldsEditor(
        date: .constant(Info.example.date),
        info: .constant(Info.example.info),
        note: .constant(Info.example.note)
    )
}
