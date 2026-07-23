import SwiftUI
import WiiKit

struct CalendarDateCell: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var periodModel: PeriodModel
    @EnvironmentObject var activityModel: ActivityModel
    @EnvironmentObject var holidayModel: HolidayModel
    @EnvironmentObject var entEventsModel: EntEventModel
    
    @ObservedObject var global = Global.shared
    
    @State var tooltipVisible = false
    
    let person: Person
    let date: Date
    
    private var period: Period? {
        periodModel.findPeriod(for: person, at: date)
    }
    private var activity: Activity? {
        if let period {
            return activityModel.findActivity(byId: period.activityId)
        }
        return nil
    }
    
    init(for person: Person, at date: Date) {
        self.person = person
        self.date = date
    }
    
    private var isHoliday: Bool {
        holidayModel.isHoliday(of: date)
    }
    private var isDayOff: Bool {
        holidayModel.isDayOff(of: date)
    }
    
    var body: some View {
        ZStack {
            // MARK: Cell borders
            
            // Current date border
            if date == Date().onlyDate {
                Rectangle().currentDate(cellSize: global.itemSize)
            }

            // DayOff border
            if date.isDayOff() {
                Rectangle().dayOff(cellSize: global.itemSize)
            }
            
            // Holiday border
            if isHoliday {
                Rectangle().holiday(cellSize: global.itemSize)
            }
            
//            // Planning activity
//            if period?.planning == true {
//                Rectangle()
//                    .stroke(activity!.color, lineWidth: 2.0)
//                    .frame(width: data.itemSize * 8/10, height: data.itemSize * 8/10)
//            }

            // MARK: Cell fill
            
            // Activity
            if activity?.abbr != nil && period!.planning == false {
                Text("\(activity!.abbr)")
                    .frame(width: global.itemSize * 7/10, height: global.itemSize * 7/10)
                    .background(activity!.color)
                    .font(.caption2)
                
            } else
            // Ent event
            if entEventsModel.isEntEvent(of: date) {
                if let event = entEventsModel.getEntEvent(of: date, shift: person.shiftNum!) {
                    if let entActivity = activityModel.findActivity(byId: event.activityId) {
                        Text(entActivity.abbr)
//                            .entEvent(color: entActivity.color)
                            .entEvent(color: .cyan)
                    }
                }
            } else {
                Rectangle()
                    .foregroundColor(date.shiftIsWorking(shift: 6) ? Color.orange.opacity(0.6) : Color.secondary.opacity(0.3))
                    .frame(width: global.itemSize * 7/10, height: global.itemSize * 7/10)
            }
        }
        .frame(width: global.itemSize, height: global.itemSize)
        .opacity(calendar.isDateInsideMonth(date, inside: global.month) ? 1.0 : 0.2)
        .onTapGesture {
            self.tooltipVisible = !self.tooltipVisible
        }
    }
}

struct CalendarDateCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDateCell(for: Person.samples[0], at: Date.now)
            .previewLayout(.sizeThatFits)
    }
}
