import SwiftUI

struct DocumentsView: View {
    private var documentURL13 = Bundle.main.url(forResource:"13", withExtension: "pdf")
    private var documentURLPRAPI = Bundle.main.url(forResource: "PRAPI", withExtension: "pdf")
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PDFKitView(url: documentURL13!)) {
                    Text("ТС-13")
                }
                NavigationLink(destination: PDFKitView(url: documentURLPRAPI!)) {
                    Text("ПРАПИ")
                }
            }
        }
    }
}

struct DocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsView()
    }
}
