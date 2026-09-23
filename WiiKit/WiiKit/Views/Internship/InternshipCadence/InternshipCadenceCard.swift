import SwiftUI

public struct InternshipCadenceCard: View {
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var morderModel: MorderModel
    
    var coach: Person? {
        if let coachId = cadence.coachId {
            return personModel.findPerson(byId: coachId)
        }
        return nil
    }
    
    private let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        formatter.groupingSeparator = ""
        return formatter
    }()
    
    var borderColor: Color {
        if cadence.suspended {
            return .red
        } else {
            return .green
        }
    }
    
    @State private var isPresentedMorderInfoView: Bool = false
    
    // MARK: - Init
    
    let cadence: InternshipCadence
    
    public init(for cadence: InternshipCadence) {
        self.cadence = cadence
    }
    
    public init(byId id: Int) {
        let model = InternshipCadenceModel()
        self.cadence = model.findInternshipCadence(byId: id)!
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            HStack(spacing: 20) {
                Group {
                    Text(cadence.period.start, style: .date)
                    Text(cadence.period.end, style: .date)
                }
                .lineLimit(1)
                .font(.caption)
                .bold()
                .padding(5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            .frame(minWidth: 260)
            
            HStack {
                Text("Приказ")
                if let id = cadence.morderId {
                    let morder = morderModel.findMorder(byId: id)!
                    Text(numberFormatter.string(from: NSNumber(value: morder.number))!)
                        .bold()
                    Text("от")
                    Text(morder.date, style: .date).bold()
                    Button(action: {
                        isPresentedMorderInfoView.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .sheet(isPresented: $isPresentedMorderInfoView) {
                        NavigationView {
                            MorderCard(for: morder)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Close") {
                                            isPresentedMorderInfoView.toggle()
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .font(.caption2)
            .foregroundColor(.secondary)

            HStack {
                if let coach {
                    PersonCard(for: coach)
                } else {
                    ZStack {
                        PersonCard(for: Person.example)
                            .hidden()
                        
                        VStack {
                            Text("Приостановка")
                            Text("стажировки")
                        }
                        .font(.subheadline).bold()
                        .foregroundColor(.red)
                    }
                }
            }
            
//            HStack {
//                Text("Приказ: ")
//                if let mandatoryOrder = cadence.mandatoryOrder {
//                    Text(mandatoryOrder)
//                        .bold()
//                }
//            }
//            .font(.caption)
//            .foregroundColor(.secondary)
        }
        .padding(10)
        .background(borderColor.opacity(0.5))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct InternshipCadenceCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipCadenceCard(for: InternshipCadence.example)
                .preferredColorScheme(.dark)
            InternshipCadenceCard(for: InternshipCadence.example)
                .preferredColorScheme(.light)
        }
        .environmentObject(PersonModel.example)
        .environmentObject(MorderModel.example)
        .previewLayout(.sizeThatFits)
    }
}
