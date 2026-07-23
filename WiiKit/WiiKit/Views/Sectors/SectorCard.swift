import SwiftUI

public struct SectorCard: View {
    @EnvironmentObject var sectorModel: SectorModel
    
    let sector: Sector
    var style: Style
    
    public init(for sector: Sector, style: Style = .regular) {
        self.sector = sector
        self.style = style
    }
    
    public var body: some View {
        HStack {
            Text(sector.label)
        }
        .foregroundColor(.white)
        .font(.footnote).bold()
        .padding()
        .background(Color.cyan)
        .cornerRadius(5)
        .shadow(radius: 3)
    }
    
    public enum Style {
        case regular
        case mini
    }
}

struct SectorCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorCard(for: Sector.example)
                .preferredColorScheme(.light)
            SectorCard(for: Sector.example)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(SectorModel())
    }
}
