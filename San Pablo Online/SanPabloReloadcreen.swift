import WebKit
import Foundation
import SwiftUI

struct SanPabloWebViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: SanPabloWebContentLoader
    
    func makeCoordinator() -> SanPabloWebViewCoordinator {
        SanPabloWebViewCoordinator { state in
            DispatchQueue.main.async {
                self.viewModel.loadState = state
            }
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = SanPabloHexColor.uiColor(from: "#141f2b")
        webView.isOpaque = false
        let dataTypes = Set([
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeLocalStorage
        ])
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes, modifiedSince: Date.distantPast) {}
        debugPrint("Renderer: \(viewModel.urlToLoad)")
        webView.navigationDelegate = context.coordinator
        viewModel.provideWebView { webView }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let dataTypes = Set([
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeLocalStorage
        ])
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes, modifiedSince: Date.distantPast) {}
    }
}

