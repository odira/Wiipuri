import SwiftUI

struct ContentView: View {    
    var body: some View {
        TabView {
            TelegramListView()
                .tabItem {
                    Image(systemName: "envelope")
                    Text("Телеграммы")
                }
            AddressView()
                .tabItem {
                    Image(systemName: "network")
                    Text("Адреса AFTN")
                }
            PhonesView()
                .tabItem {
                    Image(systemName: "phone")
                    Text("Телефоны")
                }
            DocumentsView()
                .tabItem {
                    Image(systemName: "doc.fill")
                    Text("Documents")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
