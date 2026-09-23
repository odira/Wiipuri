import SwiftUI
import WiiKit

struct PeriodEditView: View {
    @EnvironmentObject var personModel: PersonModel
    
    @Binding var period: Period
    
    private var person: Person? {
        personModel.findPerson(byId: period.personId)
    }

    @State private var personId: Int? = 0
    @State private var isPresentedPersonSearch: Bool = false
    @State private var isPresentedStartDateSearch = false
    @State private var isPresentedEndDateSearch = false
    
    // MARK: - Init

    init(for period: Binding<Period>) {
        self._period = period
    }
    
    // MARK: - Body
    
    public var body: some View {
        Form {
            Section(header: Text("Person")) {
                PersonCard(for: person!)
                Spacer()
                Button("Change") {
                    isPresentedPersonSearch.toggle()
                    personId = period.personId
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $isPresentedPersonSearch) {
                    NavigationView {
                        PersonSearchView(byId: $personId)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentedPersonSearch.toggle()
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Save") {
                                        isPresentedPersonSearch.toggle()
                                        period.personId = personId!
                                    }
                                }
                            }
                    }
                }
            }
            
            Section(header: Text("Activity")) {
                ActivityPicker(selection: $period.activityId)
                    .pickerStyle(NavigationLinkPickerStyle())
            }
            
            Section(header: Text("Period")) {
                HStack {
                    Text(period.period.start, style: .date)
                    Spacer()
                    Button("Change") {
                        isPresentedStartDateSearch = true
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: self.$isPresentedStartDateSearch) {
                        DatePicker(
                            "Choose Beginning Date",
                            selection: $period.period.start,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
                HStack {
                    Text(period.period.end, style: .date)
                    Spacer()
                    Button("Change") {
                        isPresentedEndDateSearch = true
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: self.$isPresentedEndDateSearch) {
                        DatePicker(
                            "Choose Ending Date",
                            selection: $period.period.end,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
            }
            
            Section(header: Text("Note")) {
                TextField("Note", text: Binding( get: { period.note ?? "" }, set: { period.note = $0 }))
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct PeriodEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeriodEditView(for: .constant(Period.example))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PersonModel())
        .environmentObject(ActivityModel())
    }
}
