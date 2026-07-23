import SwiftUI

public struct PositionsArrayView: View {
    @EnvironmentObject var positionModel: PositionModel
    
    var positionsArr: [Int]
    
    public init(positionsArr: [Int]) {
        self.positionsArr = positionsArr
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ForEach(positionsArr, id: \.self) { id in
                    let position = positionModel.findPosition(byId: id)
                    PositionCard(for: position!)
                }
            }
        }
    }
}

struct PositionsArrayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PositionsArrayView(positionsArr: Person.example.positionsArr)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PositionModel())
    }
}
