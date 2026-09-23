import SwiftUI

public struct InternshipEditView: View {
    @EnvironmentObject var internshipModel: InternshipModel
    @EnvironmentObject var internshipTypeModel: InternshipTypeModel
    @EnvironmentObject var personModel: PersonnelModel
    
    @Binding var data: Internship.Data
    
    @State private var personId: Int = 0
    @State private var coachId: Int = 0
    @State private var isPresentedPersonSearchView = false
    @State private var internshipCadenceData = InternshipCadence.Data()
    @State private var isPresentedAddCadenceView = false
    @State private var isPresentedEditCadenceView = false
    
    @State private var note: String = ""

    private var person: Person? {
        personModel.findPerson(byId: data.personId)
    }
    
    public init(data: Binding<Internship.Data>) {
        self._data = data
        self.personId = data.personId.wrappedValue
    }
    
    public var body: some View {
        NavigationView {
            Form {
                Section("Person") {
                    if let person {
                        PersonCard(for: person)
                    } else {
                        HStack {
                            Text("No person found!")
                            Spacer()
                            Button("Change") {
                                isPresentedPersonSearchView.toggle()
                            }
                            .buttonStyle(.borderedProminent)
                            .sheet(isPresented: $isPresentedPersonSearchView) {
                                NavigationView {
                                    PersonSearchView(personId: $personId)
                                        .toolbar {
                                            ToolbarItem(placement: .cancellationAction) {
                                                Button("Close") {
                                                    isPresentedPersonSearchView.toggle()
                                                }
                                            }
                                            ToolbarItem(placement: .confirmationAction) {
                                                Button("Apply") {
                                                    data.personId = personId
                                                    isPresentedPersonSearchView.toggle()
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                
                Section("Internship Type") {
                    InternshipTypePicker(selection: $data.internshipTypeId)
                    
                    SectorsArrayView(for: data.sectorsArr)
                    NavigationLink(
                        destination: {
                            SectorsArrayPicker(for: $data.sectorsArr)
                                .navigationTitle("Select sectors")
                        }, label: {
                            Text("Сектор стажировки")
                        }
                    )
                }

                Section(header: Text("Period")) {
                    Toggle("Planning", isOn: $data.planning)
                    HStack {
                        Text("Duration")
                        Spacer()
                        TextField("Duration", value: $data.duration, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .foregroundColor(.blue)
                    }
                }

                Section("Cadences") {
                    List {
                        HStack {
                            Spacer()
                            Button(action: {
                                internshipCadenceData = InternshipCadence.Data()
                                isPresentedAddCadenceView.toggle()
                            }, label: {
                                Label("Add New", systemImage: "plus.circle")
                                    .foregroundColor(.white)
                            })
                            .buttonStyle(.borderedProminent)
                            .sheet(isPresented: $isPresentedAddCadenceView) {
                                NavigationView {
                                    InternshipCadenceEditView(data: $internshipCadenceData)
                                        .toolbar {
                                            ToolbarItem(placement: .confirmationAction) {
                                                Button("Apply") {
                                                    var newCadence = InternshipCadence(from: internshipCadenceData)
                                                    newCadence.id = -1
                                                    data.cadences.append(newCadence)
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
                        
                        ForEach(Array(data.cadences.enumerated()), id: \.offset) { index, cadence in
                            HStack {
                                InternshipCadenceCard(cadence)
                                
                                Button("Change") {
                                    internshipCadenceData = cadence.data
                                    isPresentedEditCadenceView.toggle()
                                }
                                .buttonStyle(.borderedProminent)
                                .sheet(isPresented: $isPresentedEditCadenceView) {
                                    NavigationView {
                                        InternshipCadenceEditView(data: $internshipCadenceData)
                                            .toolbar {
                                                ToolbarItem(placement: .confirmationAction) {
                                                    Button("Apply") {
                                                        var newCadence = InternshipCadence(from: internshipCadenceData)
                                                        newCadence.id = cadence.id
                                                        data.cadences[index] = newCadence
                                                        isPresentedEditCadenceView.toggle()
                                                    }
                                                }
                                                ToolbarItem(placement: .cancellationAction) {
                                                    Button("Close") {
                                                        isPresentedEditCadenceView.toggle()
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            internshipModel.sqlInternshipDELETEcadence(data.cadences[indexSet.first!])
                            data.cadences.remove(atOffsets: indexSet)
                        }
                    }
                }
                
                Section("Дополнительные сведения") {
                    TextEditor(text: self.$note)
                        .lineLimit(10)
                        .frame(height: 200)
                        .foregroundColor(.blue)
                        .onChange(of: self.note) { _ in
                            data.note = note
                        }
                }
            }
        }
    }
}

struct InternshipEditView_Previews: PreviewProvider {
    static var previews: some View {
        InternshipEditView(data: .constant(Internship.example.data))
            .environmentObject(InternshipModel())
            .environmentObject(InternshipTypeModel())
            .environmentObject(PersonnelModel())
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
