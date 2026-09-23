import SwiftUI
import WiiKit

struct InternshipListView: View {
    @EnvironmentObject var internshipModel: InternshipModel
    @EnvironmentObject var internshipTypeModel: InternshipTypeModel
    @EnvironmentObject var personModel: PersonModel
    
    private var sortedInternships: [Internship] {
        var internships: [Internship] = internshipModel.internships
        
        if selectedStatus != .all {
            internships = internships.filter { $0.status == selectedStatus }
        }
        
        if !searchText.isEmpty {
            let ids = personModel.persons
                .filter { $0.surname.lowercased().contains(searchText.lowercased()) }
                .map { $0.id }
            internships = internships.filter { ids.contains($0.personId) }
        }
        
        return internships
    }
    
    @State private var selectedStatus: Internship.Status? = .all
    @State private var selectedInternship: Internship?
    @State private var internship: Internship = Internship()
    @State private var isPresentedAddSheet = false
    @State private var isPresentedFilterSheet = false
    
    @State private var searchText = ""
    
    private var internshipTypeName: String {
        let type = internshipTypeModel.findInternshipType(byId: internship.internshipTypeId)
        return type!.name
    }
    
    // Body
    
    var body: some View {
        NavigationSplitView {
            List(Internship.Status.allCases, id: \.id, selection: $selectedStatus) { status in
                Text(status.ruLabel).tag(status)
            }
        } content: {
            List(sortedInternships, selection: $selectedInternship) { internship in
                InternshipCard(for: internship).tag(internship)
                    .listRowSeparator(.hidden)
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                internshipModel.sqlInternshipDELETE(internship)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
            }
            .navigationBarTitle("Стажировки")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .refreshable {
                self.selectedStatus = .all
            }

            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        internship = Internship()
                        isPresentedAddSheet.toggle()
                    }) {
                        Image(systemName:  "plus")
                    }
                }
            )
            .sheet(isPresented: $isPresentedAddSheet) {
                NavigationView {
                    InternshipEditView(self.$internship)
                        .navigationTitle("Добавить стажировку")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Close") {
                                    isPresentedAddSheet.toggle()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Apply") {
                                    internshipModel.sqlInternshipINSERT(internship)
                                    isPresentedAddSheet.toggle()
                                }
                            }
                        }
                }
            }

        } detail: {
            if selectedInternship != nil {
                InternshipDetailView(for:
                    Binding(
                        get: { selectedInternship! },
                        set: { selectedInternship = $0 }
                    ))
            } else {
                Text("Select an Internship")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct InternshipListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipListView()
                .preferredColorScheme(.light)
            InternshipListView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(InternshipModel())
        .environmentObject(InternshipTypeModel.example)
        .environmentObject(PersonModel.example)
        .previewLayout(.sizeThatFits)
    }
}
