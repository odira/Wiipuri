import SwiftUI
import WiiKit

struct PeriodListView: View {
    @EnvironmentObject var periodModel: PeriodModel
    @ObservedObject var global = Global.shared
    
    @State private var isPresentedAddSheet: Bool = false
    @State private var isPresentedConfirmationDialog: Bool = false
    @State private var selectedPeriod: Period?
    @State private var addPeriod: Period = Period.example
    
    var filteredPeriods: [Period] {
        var results = periodModel.periods
        
        results = results.filter { $0.personId == person.id }
        
//        if !searchExpr.isEmpty {
//            let persons: [Person] = personnelModel.persons.filter {
//                $0.surname.contains(searchExpr.lowercased().capitalized)
//            }
//            var personIds: [Int] = []
//            for person in persons {
//                personIds.append(person.id)
//            }
//
//            results = []
//            for period in periodModel.periods {
//                for id in personIds {
//                    if period.personId == id { results.append(period) }
//                }
//            }
//        }
    
        return results
    }
    
    // MARK: - Init
    
    private var person: Person
    
    init(for person: Person) {
        self.person = person
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                PersonCard(for: person, style: .regular)
                intervalPickerView()
            }
            .padding()
            
            NavigationStack {
                List(selection: $selectedPeriod) {
                    ForEach(filteredPeriods) { period in
                        ZStack {
                            NavigationLink(destination: PeriodDetailView(
                                period: Binding(
                                    get: { period },
                                    set: { selectedPeriod = $0}
                                )
                            )) { }
                            PeriodCard(for: period, style: .regular)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            isPresentedConfirmationDialog.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                                .confirmationDialog(
                                    "Are you sure?",
                                    isPresented: $isPresentedConfirmationDialog,
                                    titleVisibility: .visible
                                ) {
                                    Button("Yes", role: .destructive) {
                                        withAnimation {
                                            periodModel.sqlPeriodDELETE(selectedPeriod!)
                                        }
                                    }
                                    .keyboardShortcut(.defaultAction)
                                    
                                    Button("No", role: .cancel) {}
                                } message: {
                                    Text("You are going to delete period...")
                                }
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
                
                .toolbar {
                    Button("\(Image(systemName: "plus.circle"))") {
                        addPeriod.personId = person.id
                        isPresentedAddSheet.toggle()
                    }
                }
                .sheet(isPresented: $isPresentedAddSheet) {
                    NavigationView {
                        PeriodEditView(for: $addPeriod)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentedAddSheet.toggle()
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Save") {
                                        isPresentedAddSheet.toggle()
                                        periodModel.sqlPeriodINSERT(addPeriod)
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
    
    // MARK: - Supporting Views
    
    enum Interval: String, CaseIterable, Identifiable {
        case month, year, all
        var id: Self { self }
    }
    
    @State private var selectedInterval: Interval = .month
    
    func intervalPickerView() -> some View {
        VStack {
            Text("Choose Interval For Searching")
            Picker("Choose Interval", selection: $selectedInterval) {
                Text("Month").tag(Interval.month)
                Text("Year").tag(Interval.year)
                Text("All").tag(Interval.all)
            }
            .onChange(of: selectedInterval, perform: { value in
                switch(value) {
                case .month:
                    guard
                        let interval = Calendar.current.dateInterval(of: .month, for: Date())
                    else { return }
                    global.startInterval = interval.start
                    global.endInterval = interval.end
                case .year:
                    guard
                        let interval = Calendar.current.dateInterval(of: .year, for: Date())
                    else { return }
                    global.startInterval = interval.start
                    global.endInterval = interval.end
                case .all:
                    guard
                        let interval = Calendar.current.dateInterval(of: .era, for: Date())
                    else { return }
                    global.startInterval = interval.start
                    global.endInterval = interval.end
                }

                periodModel.reload()
            })
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct PeriodListView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodListView(for: Person.example)
            .environmentObject(PeriodModel())
            .previewLayout(.sizeThatFits)
    }
}
