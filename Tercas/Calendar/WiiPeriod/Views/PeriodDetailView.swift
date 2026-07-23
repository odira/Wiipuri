import SwiftUI
import WiiKit

struct PeriodDetailView: View {
    @EnvironmentObject var personModel: PersonModel
    @EnvironmentObject var periodModel: PeriodModel
    
    @State private var isPresentedEditView: Bool = false
    
    @Binding var period: Period
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            PersonCard(for: personModel.findPerson(byId: period.personId)!, style: .regular)
            PeriodCard(for: period)
            
            if let note = period.note {
                Text(note)
            }
            
            Spacer()
        }
        .padding()
        
        .toolbar {
            Button("Edit") {
                isPresentedEditView.toggle()
            }
        }
        .sheet(isPresented: $isPresentedEditView) {
            NavigationStack {
                PeriodEditView(for: $period)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                isPresentedEditView.toggle()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentedEditView.toggle()
                                periodModel.sqlPeriodUPDATE(period)
                            }
                        }
                }
            }
        }
    }
}

struct PeriodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeriodDetailView(period: .constant(Period.example))
                .preferredColorScheme(.light)
            PeriodDetailView(period: .constant(Period.example))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(PersonModel())
        .environmentObject(PeriodModel())
    }
}
