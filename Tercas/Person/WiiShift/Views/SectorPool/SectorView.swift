import SwiftUI
import WiiKit

struct SectorView: View {
    
    // MARK: - Init
    
    var sector: Sector
    
    init(for sector: Sector) {
        self.sector = sector
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                SectorCard(for: sector)
                    .frame(width: 100)
            }
            .border(.black)
            
            Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 1) {
                GridRow {
                    DragDropPersonCard(for: nil)
                    DragDropPersonCard(for: nil)
                }
                .frame(height: 50)
                GridRow {
                    DragDropPersonCard(for: nil)
                    DragDropPersonCard(for: nil)
                }
                .frame(height: 50)
                GridRow {
                    DragDropPersonCard(for: nil)
                    DragDropPersonCard(for: nil)
                }
                .frame(height: 50)
            }
            .padding()
        }
    }
}

struct SectorView_Previews: PreviewProvider {
    static var previews: some View {
        SectorView(for: Sector.example)
    }
}
