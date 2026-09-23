import SwiftUI
import WiiKit

struct CalendarPoolSectionFooter: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var entEventModel: EntEventModel
    
    var total: Int
    
    @ObservedObject var global = Global.shared
    
    private var days: [Date] {
        calendar.generateDatesForExtendedMonth(for: global.month)
    }
    
    init(_ total: Int) {
        self.total = total
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .opacity(0.0)
                .frame(width: global.itemSize * 7, height: global.itemSize)
                .padding(.trailing, 3)

            ForEach(days, id:\.self) { date in
                Text("WW")
                    .hidden()
                    .overlay {
//                        Text("\(date.getDay())")
                        Text("\(total)")
                            .font(.caption)
                            .frame(width: global.itemSize * 7/9, height: global.itemSize * 7/9)
                            .foregroundColor(Color.yellow)
                            .border(Color.primary)
                    }
                    .frame(width: global.itemSize, height: global.itemSize)
            }
        }
    }
}

struct CalendarPoolSectionFooter_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPoolSectionFooter(12)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
