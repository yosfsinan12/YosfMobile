import SwiftUI
import WebKit

@main
struct YosfMobileApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        LocalWebView()
            .ignoresSafeArea()
    }
}

struct LocalWebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        // فێڵکردن بۆ ئەوەی سێرڤەری لایڤەکان نەوەستن
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 YosfMobileApp"
        
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // خوێندنەوەی فایلی index.html لەناو خودی بەرنامەکە
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let dirUrl = url.deletingLastPathComponent()
            webView.loadFileURL(url, allowingReadAccessTo: dirUrl)
        }
    }
}
