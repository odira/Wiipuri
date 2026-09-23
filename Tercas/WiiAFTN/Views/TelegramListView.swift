import SwiftUI

struct TelegramListView: View {
    var telegrams: [Telegram] = telegramsList
    
    var body: some View {
        NavigationView {
            List {
                Section("ПЛАН ПОЛЕТА") {
                    ForEach(telegrams) { telegram in
                        NavigationLink(destination: telegramDetails(for: telegram.title)) {
                            Text(telegram.title)
                        }
                    }
                }
                
                Section("АВАРИЙНЫЕ СИТУАЦИИ") {
                    Text("OK")
                }
//                Form {
//                    Section("ПЛАН ПОЛЕТА") {
//                        HStack {
//                            Text("AFIL")
//                            Spacer()
//
//                        }
//                    }
//                }
            }
            .navigationTitle("Сообщения AFTN")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TelegramListView_Previews: PreviewProvider {
    static var previews: some View {
        TelegramListView(telegrams: telegramsList)
    }
}

extension TelegramListView {
    func telegramDetails(for telegramDescription: String) -> some View {
//        let url = Bundle.main.url(forResource: telegramDescription, withExtension: "html")!
        WebView(type: .local, url: telegramDescription)
    }
}
