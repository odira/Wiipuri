import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            InternshipHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            InternshipListView()
                .tabItem {
                    Label("Стажировки", systemImage: "square.grid.3x3")
                }
            Text("SEARCH")
                .tabItem {
                    Label("Поиск", systemImage: "magnifyingglass.circle.fill")
                }
            AboutView()
                .tabItem {
                    Label("About", systemImage: "person.crop.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
