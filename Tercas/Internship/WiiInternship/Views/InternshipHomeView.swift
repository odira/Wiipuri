import SwiftUI
import WiiKit

struct InternshipHomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Стажировки")
                    .font(.title2)
                    .bold()
                
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 250, maximum: 300), spacing: 10)],
                    alignment: .leading,
                    spacing: 15
                ) {
                    ForEach(Internship.Status.allCases) { status in
                        NavigationLink(destination: InternshipsList(status: status)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 250, height: 200)
                                    .foregroundColor(status.color)
                                Text(status.ruLabel)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationViewStyle(.stack)
    }
}

struct InternshipHomeView_Previews: PreviewProvider {
    static var previews: some View {
        InternshipHomeView()
    }
}
