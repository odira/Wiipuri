import SwiftUI
import WiiKit

struct ContentView: View {
    @EnvironmentObject var morderModel: MorderModel
    @EnvironmentObject var personModel: PersonModel
    
    @State private var morder: Morder = Morder.empty
    
    @State private var isPresentedAddSheet = false
    @State private var isPresentedDeleteConfirmationDialog = false
    
    @State private var searchText: String = ""
    
    var sortedMorders: [Morder] {
        var morders = morderModel.morders
        
        if !searchText.isEmpty {
            let number = Int(searchText)
            morders = morders.filter {
                $0.number == number
            }
        }
        
        return morders
    }
    
    @State private var selectedMorder: Morder?
    
    // MARK: - Init
    
    // MARK: - Body
    
    var body: some View {
        NavigationSplitView {
            List(sortedMorders, selection: $selectedMorder) { morder in
                MorderCard(for: morder).tag(morder)
                    .listRowSeparator(.hidden)
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                isPresentedDeleteConfirmationDialog.toggle()
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .confirmationDialog(
                        "Are you sure?",
                        isPresented: $isPresentedDeleteConfirmationDialog,
                        titleVisibility: .visible
                    ) {
                        Button("Yes", role: .destructive) {
                            withAnimation {
                                morderModel.sqlMorderDELETE(morder)
                            }
                        }
                        .keyboardShortcut(.defaultAction)
                        
                        Button("No", role: .cancel) { }
                    } message: {
                        Text("You are going to delete order with number \(morder.number)")
                    }
            }
            .navigationBarTitle("Список приказов")
            .listStyle(.plain)
            .searchable(text: $searchText)
            
            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        morder = Morder.empty
                        isPresentedAddSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            )
            
            /// Morder Add Sheet
            ///
            .sheet(isPresented: $isPresentedAddSheet) {
                NavigationStack {
                    MorderEditView(morder: $morder)
                        .navigationTitle("Добавить приказ")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Close") {
                                    isPresentedAddSheet.toggle()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Apply") {
                                    morderModel.sqlMorderINSERT(morder)
                                    isPresentedAddSheet.toggle()
                                }
                            }
                        }
                }
            }
            
        } detail: {
            if selectedMorder != nil {
                MorderDetailsView(for:
                    Binding(get: { selectedMorder! }, set: { selectedMorder = $0 })
                )
            } else {
                Text("Select a Morder")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
        .environmentObject(MorderModel.example)
        .environmentObject(PersonModel.example)
        .previewLayout(.sizeThatFits)
    }
}
