import SwiftUI

public struct InternshipCard: View {
    @EnvironmentObject var internshipTypeModel: InternshipTypeModel
    @EnvironmentObject var personModel: PersonModel
    
    let internship: Internship
    
    var type: InternshipType {
        internshipTypeModel.findInternshipType(byId: internship.internshipTypeId)!
    }
    var person: Person {
        personModel.findPerson(byId: internship.personId)!
    }
    
    public init(for internship: Internship) {
        self.internship = internship
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(type.name)
                    .font(.headline)
                    .bold()
                Spacer()
                Text(internship.status.ruLabel)
                    .font(.footnote)
                    .foregroundColor(internship.status.color)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(internship.status.color, lineWidth: 1)
                    )
            }
            PersonCard(for: person, style: .regular)
        }
        .padding(10)
        .background(Color.mint.opacity(0.5))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct InternshipCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipCard(for: Internship.example)
                .preferredColorScheme(.light)
            InternshipCard(for: Internship.example)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(InternshipTypeModel.example)
        .environmentObject(PersonModel.example)
    }
}
