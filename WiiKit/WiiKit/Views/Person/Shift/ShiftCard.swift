import SwiftUI

public struct ShiftCard: View {
    var shift: Int = 0
    
    public init(shift: Int) {
        self.shift = shift
    }
    
    public var body: some View {
        Text("смена \(shift)")
            .cardModifier()
    }
}

struct ShiftCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShiftCard(shift: 0)
                .preferredColorScheme(.light)
            ShiftCard(shift: 6)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
