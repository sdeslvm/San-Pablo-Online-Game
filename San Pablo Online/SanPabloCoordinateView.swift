import WebKit
import Foundation

class SanPabloWebViewCoordinator: NSObject, WKNavigationDelegate {
    private let stateHandler: (SanPabloWebLoadState) -> Void
    private var didNavigate = false
    
    init(stateHandler: @escaping (SanPabloWebLoadState) -> Void) {
        self.stateHandler = stateHandler
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if !didNavigate { stateHandler(SanPabloWebLoadState.progress(0.0)) }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        didNavigate = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stateHandler(SanPabloWebLoadState.success())
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stateHandler(SanPabloWebLoadState.error(error))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stateHandler(SanPabloWebLoadState.error(error))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .other && webView.url != nil {
            didNavigate = true
        }
        decisionHandler(.allow)
    }
}
