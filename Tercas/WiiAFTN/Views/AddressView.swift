import SwiftUI

struct AddressView: View {
    var body: some View {
        List {
            Section("Филиал МЦ АУВД") {
                HStack {
                    Text("Региональный центр (РегЦ)")
                    Spacer()
                    Text("UUWVZDZX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("Инспекция")
                    Spacer()
                    Text("UUWVYDXX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("РДЦ")
                    Spacer()
                    Text("UUWVZRZX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("АузДЦ")
                    Spacer()
                    Text("UUWVZAZX")
                        .foregroundColor(.blue)
                }
            }
            Section("МДП") {
                HStack {
                    Text("МДП Белгород")
                    Spacer()
                    Text("UUOBZTZX UUOBZTZA UUOBYFYA")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("МДП Воронеж")
                    Spacer()
                    Text("UUOOZFZX UUOOZTZX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("МДП Калуга")
                    Spacer()
                    Text("UUBCZSZX UUBCZTZX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("МДП Нижний Новгород")
                    Spacer()
                    Text("UWGGZNZX UWGGZTZX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("МДП Тверь")
                    Spacer()
                    Text("UUBNZFZX UUEMZTZX UUEMZSZX")
                        .foregroundColor(.blue)
                }
            }
            Section("ВДПП") {
                HStack {
                    Text("ВДПП Внуково (Внуково-Вышка)")
                    Spacer()
                    Text("UUWVZSZX UUWVZGZX UUWVZTZX")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("ВДПП Шереметьево (Шереметьево-Вышка)")
                    Spacer()
                    Text("UUEEZTZX UUEEZGZA")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("ВДПП Домодедово (Домодедово-Вышка)")
                    Spacer()
                    Text("UUWVZSZX UUWVZGZX UUWVZTZX")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
