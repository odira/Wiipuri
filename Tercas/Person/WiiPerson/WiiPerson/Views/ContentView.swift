import SwiftUI

enum TabType: Int {
    case main
    case personsList
}

struct ContentView: View {
    @State private var selectedTab: TabType = .main
    var body: some View {
//        TabView(selection: $selectedTab) {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//                .tag(TabType.main)
//
//            PersonsListView()
//                .tabItem {
//                    Label("Persons", systemImage: "person.3")
//                }
//                .tag(TabType.personsList)
//        }
        
        PersonsListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
