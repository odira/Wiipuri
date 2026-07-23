import SwiftUI

public enum CardStyle: Identifiable {
    case regular, small, mini, plain
    public var id: Self { self }
}

public struct CardModifier: ViewModifier {
    var style: CardStyle
    var color: Color
    
    public func body(content: Content) -> some View {
        if style == .mini {
            content
        } else {
            content
                .foregroundColor(.secondary)
                .font(.caption2)
//                .padding([.leading, .trailing], 2)
//                .padding([.top, .bottom], 1)
                .padding(3)
                .lineLimit(1)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(.secondary, lineWidth: 1)
                )
        }
    }
}

public extension View {
    func cardModifier(_ style: CardStyle = .regular, color: Color = .primary) -> some View {
        modifier(CardModifier(style: style, color: color))
    }
}
