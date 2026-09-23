import SwiftUI

public struct PersonEditView: View {
    @EnvironmentObject var positionModel: PositionModel
    
    @State private var birthday: Date = Date.now
    @State private var isPresentedBirthdaySheet = false
    
    // MARK: - Body
    
    @Binding var person: Person
    
    public init(for person: Binding<Person>) {
        self._person = person
    }
    
    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Person's info")) {
                    TextField("Surname", text: $person.surname)
                    TextField("Name", text: $person.name)
                    TextField("Middle Name", text: $person.middleName)
                    TextField("Табельный номер", value: $person.tabNum, format: .number)
                    #if os(iOS)
                        .keyboardType(.numberPad)
                    #endif
                    SexPicker(selection: $person.sex)
                        .pickerStyle(.segmented)
                }
                
                Section(header: Text("Birthday")) {
                    HStack {
                        if person.birthday != nil {
                            Image(systemName: "calendar")
                            Text(person.birthday!, style: .date)
                        } else {
                            Label("No birthday yet", systemImage: "calendar.badge.exclamationmark")
                        }
                        Spacer()
                        Button("Изменить") {
                            isPresentedBirthdaySheet = true
                        }
                        .buttonStyle(.borderless)
                        .sheet(isPresented: self.$isPresentedBirthdaySheet) {
                            DatePicker(
                                "Choose Date",
                                selection: $birthday,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
//                            .onChange(of: birthday) { _  in
//                                data.birthday = birthday.postgresDate(in: Calendar.current.timeZone)
//                            }
                        }
                    }
                }
                
                Section(header: Text("Рабочее Направление")) {
                    SectorPoolPicker(for: $person.sectorPoolId)
                    #if os(iOS)
                        .pickerStyle(NavigationLinkPickerStyle())
                    #endif
                }
                
                Section(header: Text("Допуски на секторах")) {
                    SectorsArrayView(for: person.sectorsArr)
                    NavigationLink(
                        destination: {
                            SectorsArrayPicker(for: $person.sectorsArr)
                                .navigationTitle("Select sectors")
                        },
                        label: {
                            Text("Изменить допуски к секторам")
                                .foregroundColor(.blue)
                    })
                }
                
                Section(header: Text("Должность")) {
                    PositionPicker(for: $person.positionId)
                    #if os(iOS)
                        .pickerStyle(NavigationLinkPickerStyle())
                    #endif
                }
                
                Section(header: Text("Допуски к работе")) {
//                    PositionsArrayView(positionsArr: data.positionsArr)
//                    NavigationLink(destination: PositionsArrayPicker(positionsArr: $data.positionsArr).navigationTitle("Допуски")) {
//                        Text("Изменить допуски")
//                            .foregroundColor(.blue)
//                    }
                }
            }
        }
    }
}

struct PersonEditView_Previews: PreviewProvider {
    static var previews: some View {
        PersonEditView(for: .constant(Person.example))
            .environmentObject(PositionModel())
    }
}

extension PersonEditView {
    struct SexView: View {
        let sex: Person.Sex
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(sex.color)
                Label(sex.label, systemImage: "person")
                    .padding(4)
            }
            .background(sex.color)
        }
    }
    
    struct SexPicker: View {
        @Binding var selection: Person.Sex
        var body: some View {
            Picker("Sex", selection: $selection) {
                ForEach(Person.Sex.allCases) { label in
                    SexView(sex: label)
                        .tag(label)
                }
            }
        }
    }
    
//    func listPositionsView(ids: [Int]) -> some View {
//        VStack {
//            ForEach(ids, id: \.self) { id in
//                let position = positionModel.findPosition(byId: id)
//                PositionCard(for: position!)
//            }
//        }
//    }
}

