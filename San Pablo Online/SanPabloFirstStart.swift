import SwiftUI
import Foundation

struct SanPabloLaunchScreenView: View {
    @StateObject private var loaderVM: SanPabloWebContentLoader
    
    init(viewModel: SanPabloWebContentLoader) {
        _loaderVM = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            SanPabloWebViewContainer(viewModel: loaderVM)
                .opacity(loaderVM.loadState.type == .success ? 1 : 0.5)
            if loaderVM.loadState.type == .progress, let percent = loaderVM.loadState.percent {
                SanPabloProgressOverlayView(percent: percent)
            }
            if loaderVM.loadState.type == .error, let err = loaderVM.loadState.error {
                SanPabloErrorOverlayView(error: err)
            }
            if loaderVM.loadState.type == .offline {
                SanPabloOfflineOverlayView()
            }
        }
    }
}

private struct SanPabloProgressOverlayView: View {
    let percent: Double
    var body: some View {
        GeometryReader { proxy in
            SanPabloLoadingOverlay(progress: percent)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(Color.black)
        }
    }
}

private struct SanPabloErrorOverlayView: View {
    let error: Error
    var body: some View {
        Text("Error: \(error.localizedDescription)").foregroundColor(.red)
    }
}

private struct SanPabloOfflineOverlayView: View {
    var body: some View {
        Text("")
    }
}
