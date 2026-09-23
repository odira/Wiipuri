import SwiftUI

public struct InternshipCadenceEditView: View {
    @EnvironmentObject var personModel: PersonModel
    
    @State private var coachId: Int? = 0
    @State private var isPresentedCoachSearchView = false
    @State private var isPresentedStartDateView: Bool = false
    @State private var isPresentedEndDateView: Bool = false
    
    private var coach: Person? {
        if let coachId = self.cadence.coachId {
            return personModel.findPerson(byId: coachId)
        }
        return nil
    }
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    @Binding var cadence: InternshipCadence
    
    public init(for cadence: Binding<InternshipCadence>) {
        self._cadence = cadence
    }
    
    /// Body function
    
    public var body: some View {
        Form {
            Section("Type") {
                Toggle("Suspended", isOn: $cadence.suspended)
            }
            
            if !cadence.suspended {
                Section(header: Text("Инструктор")) {
                    NavigationLink(
                        destination: {
                            PersonSearchView(byId: $coachId)
                                .onDisappear {
                                    cadence.coachId = coachId!
                                }
                        }, label: {
                            if let coach {
                                PersonCard(for: coach, style: .regular)
                            } else {
                                Text("Tap here to select person.")
                            }
                        }
                    )
                }
            }

            Section("Period") {
                /// Date of cadence starting
                ///
                HStack {
                    Text("Start Date")
                    Spacer()

                    Button(action: {
                        isPresentedStartDateView.toggle()
                    }, label: {
                        if cadence.period.start != Date() {
                            Text(dateFormatter.string(from: cadence.period.start))
                        } else {
                            Text("Добавить")
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isPresentedStartDateView) {
                        DatePicker(
                            "Select Beginning Date",
                            selection: $cadence.period.start,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }

                /// Date of cadence ending
                ///
                HStack {
                    Text("End Date")
                    Spacer()
                    Button(dateFormatter.string(from: cadence.period.end)) {
                        isPresentedEndDateView.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isPresentedEndDateView) {
                        DatePicker(
                            "Select Ending Date",
                            selection: $cadence.period.end,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
            }

//            Section("Mandatory Order") {
//                TextField(
//                    cadence.mandatoryOrder ?? "Приказ отсутствует",
//                    text: Binding(
//                        get: { cadence.mandatoryOrder ?? "" },
//                        set: { cadence.mandatoryOrder = $0  }
//                    )
//                )
//            }

            // MARK: - Morder

            Section("Приказ о стажировке") {
                NavigationLink(destination: {
                    MorderSearchView($cadence.morderId)
                }, label: {
                    if let id = cadence.morderId {
                        MorderCard(byId: id, style: .plain)
                    } else {
                        Text("Tap here to select morder")
                    }
                })
            }

            Section("Примечание") {
                TextEditor(
                    text: Binding(
                        get: { cadence.note ?? "" },
                        set: { cadence.note = $0  }
                    )
                )
                .frame(height: 200)
                .lineLimit(10)
            }
        }
    }
}

struct InternshipCadenceEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipCadenceEditView(for: .constant(InternshipCadence.example))
        }
        .environmentObject(PersonModel.example)
    }
}
