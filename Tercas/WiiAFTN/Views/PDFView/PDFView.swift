import PDFKit
import SwiftUI

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        pdfView.autoScales = true
        pdfView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        pdfView.autoScales = true
//        pdfView.displayMode = .singlePageContinuous
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitView: View {
    var url: URL

    var body: some View {
        PDFKitRepresentedView(url)
    }
}
