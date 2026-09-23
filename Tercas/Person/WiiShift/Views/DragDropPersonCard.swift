import SwiftUI
import WiiKit

struct DragDropPersonCard: View {
    @EnvironmentObject var teamViewModel: TeamViewModel
    
    // MARK: - Init
    
    @State var person: Person?
    
    init(for person: Person?) {
        self.person = person
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            if let person {
                PersonCard(for: person, style: .mini)
                    .draggable(person)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.yellow)
            }
        }
        .dropDestination(for: Person.self) { (items: [Person], _) in
            guard let person = items.first else {
                return false
            }
            
            self.person = person
            teamViewModel.persons.removeAll(where: { $0.id == person.id })
            
            return true
        } isTargeted: { inDropArea in
            print(inDropArea)
        }
    }
}

struct DragDropPersonCard_Previews: PreviewProvider {
    static var previews: some View {
        DragDropPersonCard(for: Person.example)
    }
}
