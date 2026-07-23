import SwiftUI

public struct SectorsPoolCard: View {
    @EnvironmentObject var sectorsPoolModel: SectorPoolModel
    
    let pool: SectorPool
    
    public init(for pool: SectorPool) {
        self.pool = pool
    }
    
    public var body: some View {
        HStack {
            Text(pool.label)
        }
        .cardModifier()
    }
}

struct SectorsPoolCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorsPoolCard(for: SectorPool.example)
                .preferredColorScheme(.light)
            SectorsPoolCard(for: SectorPool.example)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(SectorPoolModel())
    }
}
