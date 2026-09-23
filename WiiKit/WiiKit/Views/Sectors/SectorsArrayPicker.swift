import SwiftUI

public struct SectorsArrayPicker: View {
    @EnvironmentObject var sectorModel: SectorModel
    
    @Binding var sectorsIdsArr: [Int]
    
    public init(for sectorsIdsArr: Binding<[Int]>) {
        self._sectorsIdsArr = sectorsIdsArr
    }
    
    private var sectorsSorted: [Sector] {
        sectorModel.sectors.sorted { $0.label < $1.label }
    }
    
    public var body: some View {
        VStack {
            List {
                ForEach(sectorsSorted) { sector in
                    HStack {
                        Text(sector.label)
                            .bold()
//                            .foregroundColor(self.sectorsIdsArr.contains(sector.id) ? .black : .gray)
                            .opacity(self.sectorsIdsArr.contains(sector.id) ? 1.0 : 0.3)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                if self.sectorsIdsArr.contains(sector.id) {
                                    self.sectorsIdsArr.removeAll(where: { $0 == sector.id })
                                } else {
                                    self.sectorsIdsArr.append(sector.id)
                                }
                            }
                        }) {
                            Image(systemName: "checkmark.rectangle.fill")
//                                .background(Color.white)
                                .foregroundColor(.green)
                                .opacity(self.sectorsIdsArr.contains(sector.id) ? 1.0 : 0.0)
                        }
                    }
                }
            }
        }
    }
}

struct SectorsArrayPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorsArrayPicker(for: .constant(Person.example.sectorsArr))
                .preferredColorScheme(.light)
        }
        .environmentObject(SectorModel())
    }
}
