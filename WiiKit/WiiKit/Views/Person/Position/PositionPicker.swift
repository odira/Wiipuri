import SwiftUI

public struct PositionPicker: View {
    @EnvironmentObject var positionModel: PositionModel
    
    @Binding var selection: Int?
    
    public init(for selection: Binding<Int?>) {
        self._selection = selection
    }
    
    public var body: some View {
        Picker("Должность", selection: $selection) {
            ForEach(positionModel.positions) {
                Text($0.position).tag($0.id as Int?)
            }
        }
    }
}

struct PositionPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PositionPicker(for: .constant(Person.example.positionId))
                .preferredColorScheme(.light)
            PositionPicker(for: .constant(Person.example.positionId))
                .preferredColorScheme(.dark)
        }
        .environmentObject(PositionModel())
        .previewLayout(.sizeThatFits)
    }
}
