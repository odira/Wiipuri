import SwiftUI
import WiiKit

struct CalendarHeader: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var entEventModel: EntEventModel
    
    @ObservedObject var global = Global.shared
    
    private var days: [Date] {
        calendar.generateDatesForExtendedMonth(for: global.month)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "person.3.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: global.itemSize * 7, height: global.itemSize)
                .foregroundColor(Color.yellow)
                .padding(.trailing, 3)

            ForEach(days, id:\.self) { date in
                VStack(spacing: 0) {
                    Text("\(date.getWeekDay())")
                        .font(.caption2)
                        .foregroundColor(date.isDayOff() ? Color.brown : Color.yellow)
                        .frame(width: global.itemSize, height: global.itemSize)
                        .opacity(calendar.isDateInsideMonth(date, inside: global.month) ? 1.0 : 0.3)
                    
                    ZStack {
                        Text("WW")
                            .hidden()
                            .overlay {
                                Text("\(date.getDay())")
                                    .font(.caption)
                                    .frame(width: global.itemSize * 7/9, height: global.itemSize * 7/9)
                                    .foregroundColor(Color.black)
                                    .background(entEventModel.isEntEvent(of: date) ? Color.cyan : Color.orange)
                                    .border(date.isDayOff() ? Color.primary : Color.clear)
                            }
                            .frame(width: global.itemSize, height: global.itemSize)
                        // DayOff border
                        if date.isDayOff() {
                            Rectangle()
                                .stroke(Color.brown, lineWidth: 2.0)
                                .frame(width: global.itemSize * 8/10, height: global.itemSize * 8/10)
                        }
                    }
                    .opacity(calendar.isDateInsideMonth(date, inside: global.month) ? 1.0 : 0.3)
                    
                }
            }
        }
    }
}

struct CalendarHeader_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeader()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
