import SwiftUI
import WiiKit

struct PersonListView: View {
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var personFilters: PersonFilters
    
    @State private var isPresentingSearch = false
    @State private var isPresentingAdd = false
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
    
    @State private var selectedPerson: Person?
    
    var body: some View {
        NavigationSplitView {
            
            List(selection: $selectedPerson) {
                ForEach(filteredPersons) { person in
                    ZStack {
                        NavigationLink(value: person) { }
                        PersonCard(for: person, style: .regular)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationBarTitle("Список работников")
            .searchable(text: $searchExpr, prompt: "Search by surname")
            .autocapitalization(.none)
            .refreshable {
                personFilters.update()
                searchExpr = ""
            }
            
            .navigationBarItems(
                trailing:
                    HStack {
                        Button(action: {
                            isPresentingSearch.toggle()
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
            )
            .sheet(isPresented: $isPresentingSearch) {
                PersonFiltersView(isPresented: self.$isPresentingSearch, personFilters: personFilters)
            }
            
        } detail: {
            if let selectedPerson {
                PeriodListView(for: selectedPerson)
            } else {
                Text("No person selected.")
            }
        }
    }
}

struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonListView()
                .preferredColorScheme(.light)
            PersonListView()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PersonModel())
        .environmentObject(PersonFilters())
    }
}
