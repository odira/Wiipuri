import SwiftUI
import WiiKit

struct SectorPoolView: View {
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    @EnvironmentObject var sectorModel: SectorModel
    
    private var sectors: [Sector] {
        sectorModel.sectors.filter { $0.poolId == pool.id }
    }
    
    @State private var selectedSectorsIds: [Int] = []
    
    // MARK: - Init
    
    private var pool: SectorPool = SectorPool.example
    
    init(for pool: SectorPool) {
        self.pool = pool
    }
    
    // MARK: = Body
    
    var body: some View {
        VStack {
            HStack {
                Text(pool.label)
                    .padding()
                    .background(.green)
                    .cornerRadius(5)
                 
                togglePoolButtons()
            }
            .padding()

            VStack(alignment: .leading) {
                ForEach(selectedSectorsIds, id: \.self) { id in
                    let sector = sectors.first(where: { $0.id == id })
                    if let sector {
                        SectorView(for: sector)
                    }
                }
            }
        }
    }
    
    func togglePoolButtons() -> some View {
        HStack {
            ForEach(sectors) { sector in
                Button(action: {
                    if selectedSectorsIds.contains(where: { $0 == sector.id }) {
                        selectedSectorsIds.removeAll(where: { $0 == sector.id })
                    } else {
                        selectedSectorsIds.append(sector.id)
                    }
                }, label: {
                    SectorCard(for: sector)
                        .opacity(selectedSectorsIds.contains { $0 == sector.id } ? 1.0 : 0.3)
                })
            }
        }
    }
}

struct SectorPoolView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorPoolView(for: SectorPool.example)
        }
        .environmentObject(SectorPoolModel())
        .environmentObject(SectorModel())
    }
}
