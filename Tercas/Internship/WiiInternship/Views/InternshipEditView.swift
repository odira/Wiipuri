import SwiftUI
import WiiKit

public struct InternshipEditView: View {
    @EnvironmentObject var internshipModel: InternshipModel
    @EnvironmentObject var internshipTypeModel: InternshipTypeModel
    @EnvironmentObject var internshipCadenceModel: InternshipCadenceModel
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var morderModel: MorderModel
    
    @State private var personId: Int? = 0
    @State private var coachId: Int = 0
    @State private var simulatorCheckDate: Date = Date()
    @State private var checkDate: Date = Date()
    @State private var boardCheckDate: Date = Date()
    
    @State private var morderId: Int? = nil
    @State private var internshipCadence: InternshipCadence = InternshipCadence()
    
    @State private var isPresentedPersonSearchView = false
    @State private var isPresentedAddCadenceView = false
    @State private var isPresentedAddMorderView = false
    @State private var isPresentedEditCadenceView = false
    @State private var isPresentedMorderSearchView = false
    @State private var isPresentedSimulatorCheckDateView = false
    @State private var isPresentedCheckDateView = false
    @State private var isPresentedBoardCheckDateView = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }

    private var person: Person? {
        personModel.findPerson(byId: internship.personId)
    }
    var cadences: [InternshipCadence] {
        internshipCadenceModel.findInternshipCadences(for: internship.id)
    }
    
    /// INPUT Parameters
    
    @Binding var internship: Internship
    
    public init(_ internship: Binding<Internship>) {
        self._internship = internship
    }
    
    /// Body function
    
    public var body: some View {
        Form {
            Section("Person") {
                NavigationLink(
                    destination: {
                        PersonSearchView(byId: $personId)
                            .onDisappear {
                                internship.personId = personId!
                            }
                    }, label: {
                        if let person {
                            PersonCard(for: person, style: .regular)
                        } else {
                            Text("Tap here to select person")
                        }
                    }
                )
            }
            
            // MARK: - Internship Type and Sectors
            
            Section("Internship Type") {
                InternshipTypePicker(selection: $internship.internshipTypeId)
                
                SectorsArrayView(for: internship.sectorsArr)
                NavigationLink(
                    destination: {
                        SectorsArrayPicker(for: $internship.sectorsArr)
                            .navigationTitle("Select sectors")
                    }, label: {
                        Text("Сектор стажировки")
                    }
                )
            }
            
            // MARK: - Morders
            
            Section("Приказы по стажировке") {
                List {
                    addMorderButton()
                    
                    if internship.mordersArr.count > 0 {
                        var morders: [Morder] {
                            let morders = internship.mordersArr.map {
                                morderModel.findMorder(byId: $0)!
                            }
                            return morders.sorted { $0.date < $1.date }
                        }
                        
                        VStack(alignment: .leading) {
                            ForEach(morders) { morder in
                                MorderCard(for: morder, style: .mini)
                            }
                        }
                    }
                }
            }
            
            // MARK: - Duration and Periods
            
            Section(header: Text("Period")) {
                Toggle("Planning", isOn: $internship.planning)
                HStack {
                    Text("Duration")
                    Spacer()
                    TextField("Duration", value: $internship.duration, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("Дата проверки на тренажере")
                    Spacer()
                    
                    Button(action: {
                        isPresentedSimulatorCheckDateView.toggle()
                    }, label: {
                        if let date = internship.simulatorCheckDate {
                            Text(dateFormatter.string(from: date))
                        } else {
                            Text("Добавить")
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isPresentedSimulatorCheckDateView) {
                        DatePicker(
                            "Select Simulator Check Date",
                            selection: $simulatorCheckDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .onChange(of: simulatorCheckDate) { _ in
                            internship.simulatorCheckDate = simulatorCheckDate
                        }
                    }
                }
                HStack {
                    Text("Дата проверки на рабочем месте")
                    Spacer()
                    
                    Button(action: {
                        isPresentedCheckDateView.toggle()
                    }, label: {
                        if let date = internship.checkDate {
                            Text(dateFormatter.string(from: date))
                        } else {
                            Text("Добавить")
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isPresentedCheckDateView) {
                        DatePicker(
                            "Select Check Date",
                            selection: $checkDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .onChange(of: checkDate) { _ in
                            internship.checkDate = checkDate
                        }
                    }
                }
                HStack {
                    Text("Дата прохождения комиссии")
                    Spacer()
                    
                    Button(action: {
                        isPresentedBoardCheckDateView.toggle()
                    }, label: {
                        if let date = internship.boardCheckDate {
                            Text(dateFormatter.string(from: date))
                        } else {
                            Text("Добавить")
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isPresentedBoardCheckDateView) {
                        DatePicker(
                            "Select Board Check Date",
                            selection: $boardCheckDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .onChange(of: boardCheckDate) { _ in
                            internship.boardCheckDate = boardCheckDate
                        }
                    }
                }
            }
            
            // MARK: - Cadences Edit Section
            
            Section("Каденции стажировки") {
                List {
                    addCadenceButton()
                    
                    ForEach(cadences) { cadence in
                        HStack {
                            InternshipCadenceCard(for: cadence)
                                .swipeActions {
                                    Button("Edit") {
                                        internshipCadence = cadence
                                        isPresentedEditCadenceView.toggle()
                                    }
                                    .tint(.green)
                                    
                                    Button("Delete") {
                                        internshipCadenceModel.sqlDELETE(cadence)
                                    }
                                    .tint(.red)
                                }
                                .sheet(isPresented: $isPresentedEditCadenceView) {
                                    NavigationStack {
                                        InternshipCadenceEditView(for: $internshipCadence)
                                            .toolbar {
                                                ToolbarItem(placement: .confirmationAction) {
                                                    Button("Apply") {
                                                        internshipCadenceModel.sqlUPDATE(internshipCadence)
                                                        isPresentedEditCadenceView.toggle()
                                                    }
                                                }
                                                ToolbarItem(placement: .cancellationAction) {
                                                    Button("Cancel") {
                                                        isPresentedEditCadenceView.toggle()
                                                    }
                                                }
                                            }
                                    }
                                }
                        }
                    }
                }
            }
            
            Section("Дополнительные сведения") {
                TextEditor(text:
                    Binding(
                        get: { internship.note ?? "" },
                        set: { internship.note = $0  }
                ))
                    .lineLimit(10)
                    .frame(height: 200)
                    .foregroundColor(.blue)
            }
        }
    }

    func addCadenceButton() -> some View {
        HStack {
            Button(action: {
                internshipCadence = InternshipCadence(internshipId: internship.id)
                isPresentedAddCadenceView.toggle()
            }, label: {
                Label("Добавить каденцию", systemImage: "plus.circle")
                    .foregroundColor(.white)
            })
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isPresentedAddCadenceView) {
                NavigationStack {
                    InternshipCadenceEditView(for: $internshipCadence)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Apply") {
                                    internshipCadenceModel.sqlINSERT(internshipCadence)
                                    isPresentedAddCadenceView.toggle()
                                }
                            }
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Close") {
                                    isPresentedAddCadenceView.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
    
    func addMorderButton() -> some View {
        Button(action: {
            isPresentedAddMorderView.toggle()
        }, label: {
            Label("Добавить приказ", systemImage: "plus.circle")
                .foregroundColor(.white)
        })
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isPresentedAddMorderView) {
            NavigationStack {
                MorderSearchView($morderId)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                isPresentedAddMorderView.toggle()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                internship.mordersArr.append(morderId!)
                                isPresentedAddMorderView.toggle()
                            }
                        }
                    }
            }
        }
    }
}

struct InternshipEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipEditView(.constant(Internship.example))
                .preferredColorScheme(.light)
            InternshipEditView(.constant(Internship.example))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(InternshipModel())
        .environmentObject(InternshipTypeModel())
        .environmentObject(InternshipCadenceModel())
        .environmentObject(PersonModel())
        .environmentObject(MorderModel.example)
    }
}

// MARK: - Extensions

extension InternshipEditView {
    struct InternshipTypePicker: View {
        @EnvironmentObject var internshipTypeModel: InternshipTypeModel
        @Binding var selection: Int
        var body: some View {
            Picker("", selection: $selection) {
                ForEach(internshipTypeModel.types) {
                    Text($0.name).tag($0.id)
                }
            }
            .lineLimit(1)
        }
    }
}
