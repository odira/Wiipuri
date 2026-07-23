import SwiftUI
import WiiKit

struct TeamView: View {
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(sectorPoolModel.pools) { pool in
                    SectorPoolView(for: pool)
                        .border(.black)
                        .padding()
                }
            }
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamView()
        }
        .environmentObject(SectorPoolModel())
        .environmentObject(SectorModel())
    }
}
