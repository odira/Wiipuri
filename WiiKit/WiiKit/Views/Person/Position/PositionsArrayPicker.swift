import SwiftUI

public struct PositionsArrayPicker: View {
    @EnvironmentObject var positionModel: PositionModel
    
    @Binding var positionsArr: [Int]
    
    public init(positionsArr: Binding<[Int]>) {
        self._positionsArr = positionsArr
    }
    
    public var body: some View {
        VStack {
            
            List(positionModel.positions) { position in
                Button(action: {
                    withAnimation {
                        if self.positionsArr.contains(position.id) {
                            self.positionsArr.removeAll(where: { $0 == position.id })
                        } else {
                            self.positionsArr.append(position.id)
                        }
                    }
                }) {
                    HStack {
                        Text(position.position)
                        Spacer()
                        Image(systemName: "checkmark")
                            .opacity(self.positionsArr.contains(position.id) ? 1.0 : 0.0)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Select person position")
            
        }
    }
}

struct PositionsArrayPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PositionsArrayPicker(positionsArr: .constant(Person.example.positionsArr))
                .preferredColorScheme(.light)
            PositionsArrayPicker(positionsArr: .constant(Person.example.positionsArr))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PositionModel())
    }
}
