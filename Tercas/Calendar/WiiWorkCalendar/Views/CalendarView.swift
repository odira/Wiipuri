import SwiftUI
import WiiKit

struct CalendarView: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var periodModel: PeriodModel
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    
    @ObservedObject var global = Global.shared
    
    @State private var selectedPerson: Person?
    
    var persons: [Person] {
        personModel.persons
    }
    var personsCollatedByPool: [Int: [Person]] {
        Dictionary(grouping: persons, by: { $0.sectorPoolId! })
    }
    var uniqueSectorsPoolsId: [Int] {
        var pools = personsCollatedByPool.map({ $0.key }).sorted()
        let indx1 = pools.firstIndex(of: 8)!
        let elem1 = pools.remove(at: indx1)
        pools.insert(elem1, at: 0)
        let indx2 = pools.firstIndex(of: 7)!
        let elem2 = pools.remove(at: indx2)
        pools.insert(elem2, at: 0)
        return pools
    }
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section(header: CalendarHeader()) {
                    ForEach(uniqueSectorsPoolsId, id:\.self) { sectorsPoolId in
                        Section(
                            header: SectorPoolButton(sectorPoolId: sectorsPoolId),
                            footer: CalendarPoolSectionFooter(personsCollatedByPool[sectorsPoolId]!.count)
                        ){
                            ForEach(personsCollatedByPool[sectorsPoolId]!) { person in
                                CalendarRow(person: person)
                                    .onTapGesture { self.selectedPerson = person }
                                    .listRowBackground(self.selectedPerson == person ? Color.gray : Color.clear)
                            }
                        }
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 5)
            .onAppear {
                global.itemSize = geo.size.width / 45
            }
        }

    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(PersonModel())
            .environmentObject(PeriodModel())
            .environmentObject(SectorPoolModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct SectorPoolButton: View {
    @EnvironmentObject var sectorPoolModel: SectorPoolModel
    let sectorPoolId: Int
    private var pool: SectorPool {
        return sectorPoolModel.findSectorPool(byId: sectorPoolId)!
    }
    
    var body: some View {
        Button(action: {
            print("SectorsPoolButton pressed")
        }) {
            Label("\(pool.label)", systemImage: "person.2.fill")
                .foregroundColor(Color.mint)
        }
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
