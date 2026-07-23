import SwiftUI
import WiiKit

struct InternshipsList: View {
    @EnvironmentObject var internshipModel: InternshipModel
    @EnvironmentObject var internshipCadenceModel: InternshipCadenceModel
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 300), spacing: 15)
    ]

    private var filteredInternships: [Internship] {
        return internshipModel.internships.filter { $0.status == self.status || internshipCadenceModel.getInternshipStatus(for: $0) == self.status }
    }

    let status: Internship.Status
    
    init(status: Internship.Status) {
        self.status = status
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 15
                ) {
                    ForEach(filteredInternships) { internship in
                        NavigationLink(
                            destination: InternshipDetailView(for: Binding(
                                get: { internship },
                                set: { $0 } ))
                        ) {
                            InternshipCard(for: internship)
                        }
                    }
                }
            }
        }
    }
}

struct InternshipsList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InternshipsList(status: .all)
                .preferredColorScheme(.light)
            InternshipsList(status: .all)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(InternshipModel())
        .environmentObject(InternshipCadenceModel())
    }
}
