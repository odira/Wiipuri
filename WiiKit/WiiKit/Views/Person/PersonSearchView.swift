import SwiftUI

public struct PersonSearchView: View {
    @EnvironmentObject var personModel: PersonModel
    
    @State private var inputText: String = ""
    
    private var filteredPersons: [Person] {
        if inputText.isEmpty {
            return personModel.persons
        } else {
            return personModel.persons.filter {
                $0.surname.lowercased().contains(inputText.lowercased())
                && $0.surname.prefix(1) == inputText.prefix(1)
            }
        }
    }
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 300), spacing: 15)
    ]
    
    /// INPUT parameter

    @Binding var personId: Int?

    public init(byId id: Binding<Int?>) {
        self._personId = id
    }
        
    public var body: some View {
        VStack {
            if let personId {
                if let person = personModel.findPerson(byId: personId) {
                    PersonCard(for: person, style: .regular)
                }
            }
            
            TextField("Введите фамилию", text: $inputText)
                .padding(.horizontal, 10)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color.init(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(12)
                .shadow(radius: 4)

            ScrollView(.vertical) {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 15
                ) {
                    ForEach(filteredPersons) { person in
                        PersonCard(for: person, style: .regular)
                            .onTapGesture {
                                inputText = person.surname
                                personId = person.id
                            }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct PersonSearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonSearchView(byId: .constant(Person.example.id))
                .preferredColorScheme(.light)
            PersonSearchView(byId: .constant(Person.example.id))
                .preferredColorScheme(.dark)
        }
        .environmentObject(PersonModel.example)
        .previewLayout(.sizeThatFits)
    }
}
