import SwiftUI
import WiiKit

struct InternshipDetailView: View {
    @EnvironmentObject var internshipModel: InternshipModel
    @EnvironmentObject var internshipTypeModel: InternshipTypeModel
    @EnvironmentObject var internshipCadenceModel: InternshipCadenceModel
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var morderModel: MorderModel
    
    private var type: InternshipType {
        internshipTypeModel.findInternshipType(byId: internship.internshipTypeId)!
    }
    private var person: Person {
        personModel.findPerson(byId: internship.personId)!
    }
    private var cadences: [InternshipCadence] {
        internshipCadenceModel.findInternshipCadences(for: internship.id)
    }
    
    @State private var isPresentedEditMode: Bool = false
    
    // MARK: - Init
    
    @Binding var internship: Internship
    
    init(for internship: Binding<Internship>) {
        self._internship = internship
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView([.vertical]) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 50) {
                    Text(type.name)
                        .font(.largeTitle).bold()
                    
                    Text(internship.status.ruLabel)
                        .font(.title3).bold()
                        .foregroundColor(internship.status.color)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(internship.status.color, lineWidth: 1)
                        )
                    
                    Spacer()
                }
                
                /// Person Card
                
                PersonCard(for: person, style: .regular)
                
                /// Morders Cards
                
                if !internship.mordersArr.isEmpty {
                    Divider()
                    Text("Приказы о стажировке").bold()
                    
                    var morders: [Morder] {
                        let morders = internship.mordersArr.map {
                            morderModel.findMorder(byId: $0)!
                        }
                        return morders.sorted { $0.date < $1.date }
                    }
                    
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 300, maximum: 300), spacing: 10)],
                        alignment: .leading,
                        spacing: 10
                    ) {
                        ForEach(morders) { morder in
                            MorderCard(for: morder, style: .mini)
                        }
                    }
                    
                }
                
                /// Sectors Array
                
                if  internship.internshipTypeId == 1 ||
                        internship.internshipTypeId == 5 ||
                        internship.internshipTypeId == 6 {
                    
                    if internship.sectorsArr.count > 0 {
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Стажировка на сектор")
                                .font(.headline).bold()
                            
                            SectorsArrayView(for: internship.sectorsArr)
                        }
                    }
                }
                
                /// Duration, Period and Checking Dates
                
                if let duration = internship.duration {
                    Divider()
                    Text("Период, длительность и даты проверок")
                        .bold()
                    
                    VStack(alignment: .leading) {
                        if !cadences.isEmpty {
                            let startDate = cadences[0].period.start
                            let endDate = cadences[cadences.count - 1].period.end
                            HStack(spacing: 10) {
                                Text("Период стажировки")
                                    .font(.caption)
                                Group {
                                    Text(startDate, style: .date)
                                    Text(endDate, style: .date)
                                }
                                .lineLimit(1)
                                .font(.caption)
                                .bold()
                                .padding(5)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            }
                        }
                        
                        HStack {
                            Text("Длительность стажировки (часы): ")
                                .font(.caption)
                            Text(duration, format: .number)
                                .bold()
                        }
                        
                        if let simulatorCheckDate = internship.simulatorCheckDate {
                            HStack {
                                Text("Проверка на тренажере")
                                    .font(.caption)
                                Text(simulatorCheckDate, style: .date)
                                    .lineLimit(1)
                                    .font(.caption)
                                    .bold()
                                    .padding(5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                        
                        if let checkDate = internship.checkDate {
                            HStack {
                                Text("Проверка на рабочем месте")
                                    .font(.caption)
                                Text(checkDate, style: .date)
                                    .lineLimit(1)
                                    .font(.caption)
                                    .bold()
                                    .padding(5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                        
                        if let boardCheckDate = internship.boardCheckDate {
                            HStack {
                                Text("Дата комиссии на допуск")
                                    .font(.caption)
                                Text(boardCheckDate, style: .date)
                                    .lineLimit(1)
                                    .font(.caption)
                                    .bold()
                                    .padding(5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                
                /// Cadences
                
                if !cadences.isEmpty {
                    VStack(alignment: .leading) {
                        Divider()
                        
                        Text("Каденции стажировки")
                            .font(.headline).bold()
                        
                        let columns = [
                            GridItem(.adaptive(minimum: 300, maximum: 300), spacing: 10)
                        ]
                        LazyVGrid(
                            columns: columns,
                            alignment: .leading,
                            spacing: 20
                        ) {
                            ForEach(cadences) { cadence in
                                InternshipCadenceCard(for: cadence)
                            }
                        }
                    }
                }
                
                /// Note
                
                if let note = internship.note {
                    VStack(alignment: .leading) {
                        Divider()
                        Text("Дополнительные сведения")
                            .font(.headline).bold()
                        Text(note)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
        
        .toolbar {
            Button("Edit") {
                isPresentedEditMode.toggle()
            }
        }
        .sheet(isPresented: $isPresentedEditMode) {
            NavigationView {
                InternshipEditView($internship)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Apply") {
                                internshipModel.sqlInternshipUPDATE(internship)
                                reload()
                                isPresentedEditMode.toggle()
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                isPresentedEditMode.toggle()
                            }
                        }
                    }
            }
        }
    }
    
    func reload() {
        let id = internship.id
        self.internship = internshipModel.findInternship(byId: id)!
    }
}

struct InternshipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipDetailView(for: .constant(InternshipModel.example))
                .preferredColorScheme(.light)
            InternshipDetailView(for: .constant(InternshipModel.example))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(InternshipModel())
        .environmentObject(InternshipTypeModel.example)
        .environmentObject(InternshipCadenceModel())
        .environmentObject(PersonModel.example)
        .environmentObject(MorderModel.example)
    }
}
