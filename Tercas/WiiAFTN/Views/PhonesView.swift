import SwiftUI

struct PhonesView: View {
    var body: some View {
        List {
            Section("Телефоны") {
                VStack(alignment: .leading) {
                    Text("Начальник смены РегЦ")
                    Text("98 (495) 130 15 91")
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading) {
                    Text("ПВО")
                    Text("98 (482) 322 72 73")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct PhonesView_Previews: PreviewProvider {
    static var previews: some View {
        PhonesView()
    }
}
