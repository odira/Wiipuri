import SwiftUI

public struct PersonCard: View {
    @EnvironmentObject var positionModel: PositionModel
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    
    @ObservedObject var global = Global.shared

    var person: Person
    
    var position: Position? {
        return positionModel.findPosition(byId: person.positionId!)
    }
    var sectorPool: SectorPool? {
        if person.sectorPoolId != nil {
            return sectorPoolModel.findSectorPool(for: person)
        }
        return nil
    }
    
    private var itemSize: CGFloat {
        switch self.style {
        case .regular:
            return 45
        case .mini, .small, .plain:
            return 35
        }
    }
    var style: CardStyle
    
    public init(for person: Person, style: CardStyle = .mini) {
        self.person = person
        self.style = style
    }
    
    public var body: some View {
        switch self.style {
        case .regular:
            VStack(alignment: .leading) {
                HStack {
                    PersonImage(for: person, style: self.style, itemSize: itemSize)
                    VStack(alignment: .leading) {
                        Text(person.surname)
                            .font(.headline)
                            .fontWeight(.bold)
                        HStack {
                            Text(person.name)
                            Text(person.middleName)
                        }
                        .font(.subheadline)
                        .lineLimit(1)
                    }
                }
                
                VStack(spacing: 0) {
                    HStack {
                        if let position {
                            Text(position.position)
                        }
                        Spacer()
                        if let shiftNum = person.shiftNum {
                            Text("Смена \(shiftNum)")
                        }
                    }
                    HStack {
                        if let klass = person.klass {
                            Text("\(klass) класс")
                        }
                        Spacer()
                        if let sectorPool {
                            Text(sectorPool.label)
                        }
                    }
                }
                .font(.caption)
            }
            .foregroundColor(.white)
            .padding()
            .background(person.sex.color)
            .cornerRadius(12)
            .shadow(radius: 5)
            
        case .small, .mini, .plain:
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    PersonImage(for: person, style: self.style, itemSize: itemSize)
                    VStack(alignment: .leading) {
                        Text(person.initials)
                            .font(.footnote)
                            .bold()
                        if let position {
                            Text(position.position)
                                .font(.caption)
                        }
                    }
                    Spacer()
                }
//                .overlay(
//                    RoundedRectangle(cornerRadius: 5)
//                        .background(person.sex.color.opacity(0.3))
//                )
                .background(person.sex.color.opacity(0.3))
            }
//            .padding(3)
            .frame(maxWidth: 200)
            .padding(5)
        }
    }
}

struct PersonCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonCard(for: Person.samples[0], style: .mini)
                .preferredColorScheme(.light)
            PersonCard(for: Person.samples[0], style: .mini)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PositionModel())
        .environmentObject(SectorPoolModel())
    }
}

// MARK: -- Image for Person

fileprivate struct PersonImage: View {
    var person: Person
    var style: CardStyle
    var itemSize: CGFloat
    
    init(for person: Person, style: CardStyle = .regular, itemSize: CGFloat = 50) {
        self.person = person
        self.style = style
        self.itemSize = itemSize
    }
    
    var body: some View {
        person.image
            .resizable()
            .frame(width: itemSize, height: itemSize)
            .clipShape(RoundedRectangle(cornerRadius: itemSize / 8))
            .overlay(
                RoundedRectangle(cornerRadius: itemSize / 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(person.sex.color)
            )
    }
}
