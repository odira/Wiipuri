import SwiftUI

public struct SectorsArrayView: View {
    @EnvironmentObject var sectorModel: SectorModel
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    
    var sectorsArr: [Int]
    var style: Style
    
    private var sectorsPoolIds: [Int] {
        let arr = sectorsArr.compactMap { sectorModel.findSector(byId: $0)!.poolId }
        return Array(Set(arr))
    }
    
    public init(for sectorsArr: [Int], style: Style = .mini) {
        self.sectorsArr = sectorsArr
        self.style = style
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(sectorsPoolIds, id: \.self) { poolId in
//                if let sectorsPool = sectorsPoolModel.findSectorsPool(byId: poolId) {
//                    Text(sectorsPool.pool)
//                        .bold()
//                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(sectorsArr, id: \.self) { id in
                            let sector = sectorModel.findSector(byId: id)
                            if sector!.poolId == poolId {
                                SectorCard(for: sector!)
                            }
                        }
                    }
                }
            }
        }
    }
    
    public enum Style {
        case regular
        case mini
    }
}

struct SectorsArrayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorsArrayView(for: Person.example.sectorsArr)
                .preferredColorScheme(.light)
            SectorsArrayView(for: Person.example.sectorsArr)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(SectorModel())
        .environmentObject(SectorPoolModel())
    }
}
