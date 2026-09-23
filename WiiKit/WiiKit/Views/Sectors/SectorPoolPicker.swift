import SwiftUI

public struct SectorPoolPicker: View {
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    
    @Binding var selection: Int?
    
    public init(for selection: Binding<Int?>) {
        self._selection = selection
    }
    
    public var body: some View {
        Picker("Направление", selection: $selection) {
            ForEach(sectorPoolModel.pools) {
                Text($0.label).tag($0.id as Int?)
            }
        }
    }
}

struct SectorPoolPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectorPoolPicker(for: .constant(Person.example.sectorPoolId!))
                .preferredColorScheme(.light)
            SectorPoolPicker(for: .constant(Person.example.sectorPoolId!))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(SectorPoolModel())
    }
}
