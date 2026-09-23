import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 0) {
            Header()
                .padding()
            CalendarView()
                .listStyle(PlainListStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
