import SwiftUI
import WiiKit

struct Header: View { 
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var periodModel: PeriodModel
    
    @ObservedObject var global = Global.shared
    
    private let yearFormatter = DateFormatter.year
    private let monthFormatter = DateFormatter.month
    
    var body: some View {
        HStack(spacing: 20) {
            HStack {
                Group {
                    Button(action: {
                        global.setCurrentMonth()
                        periodModel.reload()
                    }) {
                        Image(systemName: "dot.square").resizable()
                    }
                }
                .foregroundColor(Color.green)
                .frame(width: 25, height: 25)
            }
            
            HStack {
                Group {
                    Button(action: {
                        global.addingYears(-1)
                        periodModel.reload()
                    }) {
                        Image(systemName: "chevron.left.square").resizable()
                    }
                    Button(action: {
                        global.addingYears(1)
                        periodModel.reload()
                    }) {
                        Image(systemName: "chevron.right.square").resizable()
                    }
                }
                .foregroundColor(Color.blue)
                .frame(width: 25, height: 25)
                Text("\(yearFormatter.string(from: global.month))")
            }
            
            HStack {
                Group {
                    Button(action: {
                        global.addingMonths(-1)
                        periodModel.reload()
                    }) {
                        Image(systemName: "chevron.left.square").resizable()
                    }
                    Button(action: {
                        global.addingMonths(1)
                        periodModel.reload()
                    }) {
                        Image(systemName: "chevron.right.square").resizable()
                    }
                }
                .foregroundColor(Color.purple)
                .frame(width: 25, height: 25)
                Text("\(monthFormatter.string(from: global.month))")
            }
            
            HStack {
                Group {
                    Button(action: {
                        global.changeShiftNumber(by: -1)
                        personModel.reload()
                        periodModel.reload()
                    }) {
                        Image(systemName: "chevron.left.square").resizable()
                    }
                    Button(action: {
                        global.changeShiftNumber(by: 1)
                        personModel.reload()
                        periodModel.reload()
                    }) {
                        Image(systemName: "chevron.right.square").resizable()
                    }
                }
                .foregroundColor(Color.orange)
                .frame(width: 25, height: 25)
                Text("смена \(global.shiftNum)")
            }
        }
        .font(.headline)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .environmentObject(PersonModel())
            .environmentObject(PeriodModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
