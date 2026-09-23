import SwiftUI

public extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden { self.hidden() }
        else { self }
    }
    
    func endTextEditing() {
        #if os(iOS)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}

struct EntEventModifier: ViewModifier {
    @ObservedObject var global = Global.shared
    
    var color: Color
    
    init(color: Color = Color.clear) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: global.itemSize * 8/10, height: global.itemSize * 8/10)
            .background(self.color)
            .font(.caption2)
    }
}

public extension View {
    func entEvent(color: Color = Color.clear) -> some View {
        modifier(EntEventModifier(color: color))
    }
}

// MARK: View Builders for date cells

public extension View {
    @ViewBuilder func currentDate(cellSize: CGFloat) -> some View {
        self
            .foregroundColor(Color.clear)
            .frame(width: cellSize * 1.1, height: cellSize * 1.1)
            .border(Color.primary, width: 2.5)
    }
}

public extension Rectangle {
    @ViewBuilder func dayOff(cellSize: CGFloat) -> some View {
        self
            .stroke(Color.brown, lineWidth: 2.0)
            .frame(width: cellSize * 8/10, height: cellSize * 8/10)
    }
    
    @ViewBuilder func holiday(cellSize: CGFloat) -> some View {
        self
            .stroke(Color.red, lineWidth: 1.5)
            .frame(width: cellSize * 8/10, height: cellSize * 8/10)
    }
}
