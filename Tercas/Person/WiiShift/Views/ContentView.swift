import SwiftUI
import WiiKit

struct ContentView: View {
    var body: some View {
        HStack(spacing: 10) {
            PersonListView()
                .border(.black)
            
            Divider()
            
            TeamView()
                .border(.black)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
