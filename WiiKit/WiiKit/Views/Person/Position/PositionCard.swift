import SwiftUI

public struct PositionCard: View {
    @EnvironmentObject var positionModel: PositionModel
    
    let position: Position
    let style: CardStyle
    
    public init(for position: Position, style: CardStyle = .regular) {
        self.position = position
        self.style = style
    }
    
    public var body: some View {
        HStack {
            if style == .mini {
                Text(position.position)
                    .font(.caption2)
            } else {
                if let icon = position.icon {
                    Text(icon)
                }
                Text(position.position)
            }
        }
        .cardModifier(style)
    }
}

struct PositionCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PositionCard(for: Position.example)
                .preferredColorScheme(.light)
            PositionCard(for: Position.example)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PositionModel())
    }
}
