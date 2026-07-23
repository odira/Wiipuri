import SwiftUI
import WiiKit

struct CalendarRow: View {
    @Environment(\.calendar) var calendar

    @ObservedObject var global = Global.shared
    
    let person: Person
    
    private var days: [Date] {
        calendar.generateDatesForExtendedMonth(for: global.month)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            PersonCard(for: person, style: .mini)
                .frame(width: global.itemSize * 7 + 3, height: global.itemSize)
            
            HStack(spacing: 0) {
                ForEach(days, id:\.self) { date in
                    CalendarDateCell(for: person, at: date)
                }
            }
        }
        .frame(height: global.itemSize * 6/10)
    }
}

struct CalendarRow_Previews: PreviewProvider {
    static var previews: some View {
        CalendarRow(person: Person.samples[0])
            .environmentObject(PeriodModel())
            .environmentObject(ActivityModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
