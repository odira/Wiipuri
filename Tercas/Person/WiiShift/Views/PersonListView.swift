import SwiftUI
import WiiKit

struct PersonListView: View {
    @EnvironmentObject var teamViewModel: TeamViewModel
    
    var sortedPersons: [Person] {
        teamViewModel.persons
    }
    
    var body: some View {
        ScrollView {
            ForEach(sortedPersons) { person in
                PersonCard(for: person, style: .mini)
                    .draggable(person)
            }
        }
    }
}

struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonListView()
                .preferredColorScheme(.light)
            PersonListView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(PersonModel.example)
    }
}
