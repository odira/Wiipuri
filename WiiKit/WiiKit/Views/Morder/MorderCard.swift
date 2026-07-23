import SwiftUI

public struct MorderCard: View {
    @EnvironmentObject var morderModel: MorderModel
    @EnvironmentObject var personModel: PersonModel
    
    var morderId: Int
    
    var morder: Morder
    var style: CardStyle
    
    public init(for morder: Morder, style: CardStyle = .regular) {
        self.morderId = morder.id
        self.morder = morder
        self.style = style
    }
    
    public init(byId morderId: Int, style: CardStyle = .regular) {
        self.morderId = morderId
        self.morder = MorderModel().findMorder(byId: morderId)!
        self.style = style
    }
    
    private let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        formatter.groupingSeparator = ""
        return formatter
    }()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Приказ №")
                Text(numberFormatter.string(from: NSNumber(value: morder.number))!)
                    .bold()
                Text("от")
                Text(morder.date, formatter: dateFormatter)
                    .bold()
                    .lineLimit(1)
                    .bold()
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                Spacer()
            }
            Text(morder.title ?? "")
                .bold()
                .lineLimit(2)
                .font(.headline)
                .multilineTextAlignment(.center)
            switch style {
            case .regular:
                if let id = morder.personId {
                    let person = personModel.findPerson(byId: id)
                    PersonCard(for: person!, style: .regular)
                }
            case .small, .mini, .plain:
                EmptyView()
            }
        }
        .font(.caption)
        .padding(10)
        .background(.green.opacity(0.5))
        .cornerRadius(12)
    }
}

struct MorderCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MorderCard(for: Morder.example, style: .regular)
                .preferredColorScheme(.light)
            MorderCard(for: Morder.example, style: .mini)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(MorderModel.example)
        .environmentObject(PersonModel.example)
    }
}
