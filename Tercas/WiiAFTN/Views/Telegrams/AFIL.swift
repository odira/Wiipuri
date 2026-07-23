import SwiftUI

struct AFIL: View {
    var body: some View {
        let url = Bundle.main.url(forResource: "AFIL", withExtension: "html")!
        WebView(type: .local, url: "AFIL")
    }
}

struct AFIL_Previews: PreviewProvider {
    static var previews: some View {
        AFIL()
    }
}
