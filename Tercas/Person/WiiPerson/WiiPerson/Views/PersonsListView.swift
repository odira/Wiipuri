import SwiftUI
import WiiKit

struct PersonsListView: View {
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var personFilters: PersonFilters
    
    @State private var isPresentedSearchSheet = false
    @State private var isPresentedAddSheet = false
    @State private var isPresentedConfirmationSheet = false
    @State private var selectedPerson: Person?
    @State private var person: Person = Person()
    @State private var searchExpr: String = ""
    
    var filteredPersons: [Person] {
        var results = personModel.persons
        
        if !searchExpr.isEmpty {
            results = results.filter { $0.surname.contains(searchExpr.lowercased().capitalized) }
        }
    
//        switch personFilters.byValid {
//        case .all:
//            break
//        case .valid:
//            results.removeAll(where: {!$0.valid!})
//        case .invalid:
//            results.removeAll(where: {$0.valid!})
//        }
    
        if !personFilters.byName.isEmpty {
            results = results.filter { $0.name.contains(personFilters.byName.lowercased().capitalized) }
        }
        if !personFilters.byMiddlename.isEmpty {
            results = results.filter { $0.middleName.contains(personFilters.byMiddlename.lowercased().capitalized) }
        }
        if !personFilters.bySurname.isEmpty {
            results = results.filter { $0.surname.contains(personFilters.bySurname.lowercased().capitalized) }
        }
    
        results = results.filter { personFilters.byShiftNum == 0 || $0.shiftNum == personFilters.byShiftNum }
    
        return results
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationSplitView {
            
            List(selection: $selectedPerson) {
                ForEach(filteredPersons) { person in
                    ZStack {
                        NavigationLink(value: person) { }
                        PersonCard(for: person, style: .regular)
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        isPresentedConfirmationSheet.toggle()
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .confirmationDialog(
                                "Are you sure?",
                                isPresented: $isPresentedConfirmationSheet,
                                titleVisibility: .visible
                            ) {
                                Button("Yes", role: .destructive) {
                                    withAnimation {
                                        personModel.sqlDELETE(person)
                                    }
                                }
                                .keyboardShortcut(.defaultAction)
                                
                                Button("No", role: .cancel) { }
                            } message: {
                                Text("You are going to delete person...")
                        }   }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                personFilters.update()
            }
            .searchable(text: $searchExpr, prompt: "Search by surname")
            .autocapitalization(.none)
            .navigationBarTitle("Список работников")
            
            .navigationBarItems(
                leading:
                    HStack {
                        Button(action: { isPresentedAddSheet.toggle() }) {
                            Image(systemName: "plus")
                        }
                    },
                trailing:
                    HStack {
                        Button(action: { isPresentedSearchSheet.toggle() }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
            )
            .sheet(isPresented: $isPresentedAddSheet) {
                addPersonView(isPresented: $isPresentedAddSheet)
            }
            .sheet(isPresented: $isPresentedSearchSheet) {
                PersonFiltersView(isPresented: self.$isPresentedSearchSheet, personFilters: personFilters)
            }
            
        } detail: {
            if let selectedPerson {
                PersonDetailView(
                    for: Binding (
                        get: { selectedPerson },
                        set: { self.selectedPerson = $0 }
                ))
            } else {
                Text("No person selected.")
            }
        }
    }
}

// MARK: - Preview

struct PersonsListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListView()
            .environmentObject(PersonModel())
            .environmentObject(PersonFilters())
    }
}

// MARK: - Additional Views

extension PersonsListView {
    func addPersonView(isPresented: Binding<Bool>) -> some View {
        NavigationView {
            PersonEditView(for: self.$person)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentedAddSheet.toggle()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            personModel.sqlINSERT(self.person)
                            isPresentedAddSheet.toggle()
                        }
                    }
                }
        }
    }
}
