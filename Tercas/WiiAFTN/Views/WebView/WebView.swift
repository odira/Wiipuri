import Foundation
import Combine
import SwiftUI
import WebKit
import UIKit

enum URLType {
    case local, `public`
}

struct WebView: UIViewRepresentable {
    var type: URLType
    var url: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if type == .local {
                if let localUrl = Bundle.main.url(forResource: urlValue, withExtension: "html", subdirectory: "") {
                    webView.loadFileURL(localUrl, allowingReadAccessTo: localUrl.deletingLastPathComponent())
                }
            } else if type == .public {
                if let requestUrl = URL(string: urlValue) {
                    webView.load(URLRequest(url: requestUrl))
                }
            }
        }
    }
}
