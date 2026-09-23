import SwiftUI

public struct MorderSearchView: View {
    @EnvironmentObject var morderModel: MorderModel
    
    @State private var inputText: String = ""

    private var filteredMorders: [Morder] {
        if inputText.isEmpty {
            return morderModel.morders
        } else {
            return morderModel.morders.filter {
                $0.number == Int(inputText)
            }
//            return personModel.persons.filter {
//                $0.surname.lowercased().contains(inputText.lowercased())
//                && $0.surname.prefix(1) == inputText.prefix(1)
//            }
        }
    }
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 300), spacing: 15)
    ]
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()
    
    /// INPUT parameter

    @Binding var morderId: Int?

    public init(_ morderId: Binding<Int?>) {
        self._morderId = morderId
    }
        
    public var body: some View {
        VStack {
            if let morderId {
                MorderCard(byId: morderId)
            }
            
            TextField("Введите номер приказа", text: $inputText)
                .padding(.horizontal, 10)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color.init(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(12)
                .shadow(radius: 4)

            ScrollView(.vertical) {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 15
                ) {
                    ForEach(filteredMorders) { morder in
                        MorderCard(for: morder, style: .plain)
                            .onTapGesture {
                                morderId = morder.id
                            }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct MorderSearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MorderSearchView(.constant(0))
                .preferredColorScheme(.light)
            MorderSearchView(.constant(0))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(MorderModel.example)
    }
}
