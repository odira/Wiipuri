import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("atc")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
                .opacity(0.6)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
