import SwiftUI

public struct SectorPoolSearchView: View {
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    
    @Binding var id: Int
    
    @State private var inputText: String = ""
    @FocusState private var nameInFocus: Bool
    
    private var filteredSectorPool: [SectorPool] {
        return sectorPoolModel.pools.filter {
            $0.label.lowercased().contains(inputText.lowercased())
        }
    }
    
    public init(id: Binding<Int>) {
        self._id = id
    }
        
    public var body: some View {
        VStack {
            HStack {
                TextField("Enter pool for search", text: $inputText)
                    .disableAutocorrection(true)
                #if os(iOS)
                    .autocapitalization(.none)
                #endif
                    .padding()
                #if os(iOS)
                    .border(Color(UIColor.separator))
                #endif
                    .focused($nameInFocus)
                Button("Clear") {
                    inputText = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            if filteredSectorPool.count > 0 {
                List {
                    ForEach(filteredSectorPool) { pool in
                        Text(pool.label)
                            .onTapGesture {
                                inputText = pool.label
                                self.id = pool.id
                            }
                    }
                }
//                .listStyle(GroupedListStyle())
            }
            Spacer()
        }
        .onAppear {
            if let pool = sectorPoolModel.findSectorPool(byId: self.id) {
                self.inputText = pool.label
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
              self.nameInFocus = true
            }
        }
    }
}

struct SectorPoolSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SectorPoolSearchView(id: .constant(2))
            .environmentObject(SectorPoolModel())
    }
}
