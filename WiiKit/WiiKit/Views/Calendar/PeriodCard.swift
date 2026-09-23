import SwiftUI

public struct PeriodCard: View {
    @EnvironmentObject var activityModel: ActivityModel
    
    private var activity: Activity {
        activityModel.findActivity(byId: period.activityId)!
    }
    private var startDate: Date {
        period.period.start
    }
    private var endDate: Date {
        period.period.end
    }
    private var numberOfDaysBetween: Int {
        let startDate = period.period.start
        let endDate = period.period.end
        return Calendar.current.numberOfDaysBetween(startDate, and: endDate) + 1
    }

    let formatter = DateFormatter.longDateFormatter
    
    // MARK: - Init
    
    var period: Period
    var style: CardStyle
    
    public init(for period: Period, style: CardStyle = .mini) {
        self.period = period
        self.style = style
    }
    
    // MARK: - Body
    
    public var body: some View {
        switch self.style {
        case .regular:
            
            VStack(alignment: .leading) {
                HStack {
                    ActivityCard(for: activity)
                    Spacer()
                    if period.planning {
                        Text("planning")
                            .foregroundColor(.primary)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 3)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.title)
                    Group {
                        Text(startDate, style: .date)
                        if startDate != endDate {
                            Text(endDate, style: .date)
                        }
                    }
                    .lineLimit(1)
                    .bold()
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                }
                
                HStack {
                    Image(systemName: "figure.walk")
                        .font(.title2)
                    Text("Продолжительность **\(numberOfDaysBetween)** дней")
//                        .foregroundColor(Color.secondary)
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.gray)
            .cornerRadius(12)
            .shadow(radius: 5)
            
        case .small, .mini, .plain:
            
            VStack(alignment: .leading) {
                HStack {
                    ActivityCard(for: activity)
                    Spacer()
                    if period.planning {
                        Text("planning")
                            .font(.caption)
                            .foregroundColor(.primary)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 3)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                }
                
                HStack {
                    Text("\(formatter.string(from: startDate))")
                    if numberOfDaysBetween > 1 {
                        Text(" - \(formatter.string(from: endDate))")
                    }
                }
                .foregroundColor(Color.blue)
                .font(.callout)
                
                Text("Duration \(numberOfDaysBetween) days")
                    .foregroundColor(Color.secondary)
                    .font(.callout)
            }
        }
    }
}

struct PeriodCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeriodCard(for: Period.samples[0], style: .regular)
                .preferredColorScheme(.light)
            PeriodCard(for: Period.samples[0], style: .regular)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(ActivityModel())
    }
}
