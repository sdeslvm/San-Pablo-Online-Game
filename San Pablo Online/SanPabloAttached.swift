import Foundation
import SwiftUI
import WebKit

struct SanPabloWebLoadState: Equatable {
    enum SanPabloWebLoadType: Int {
        case idle = 0
        case progress
        case success
        case error
        case offline
    }
    let type: SanPabloWebLoadType
    let percent: Double?
    let error: Error?
    
    static func idle() -> SanPabloWebLoadState {
        SanPabloWebLoadState(type: .idle, percent: nil, error: nil)
    }
    static func progress(_ percent: Double) -> SanPabloWebLoadState {
        SanPabloWebLoadState(type: .progress, percent: percent, error: nil)
    }
    static func success() -> SanPabloWebLoadState {
        SanPabloWebLoadState(type: .success, percent: nil, error: nil)
    }
    static func error(_ err: Error) -> SanPabloWebLoadState {
        SanPabloWebLoadState(type: .error, percent: nil, error: err)
    }
    static func offline() -> SanPabloWebLoadState {
        SanPabloWebLoadState(type: .offline, percent: nil, error: nil)
    }
    
    static func == (lhs: SanPabloWebLoadState, rhs: SanPabloWebLoadState) -> Bool {
        if lhs.type != rhs.type { return false }
        switch lhs.type {
        case .progress:
            return lhs.percent == rhs.percent
        case .error:
            return true // Не сравниваем ошибки по содержимому
        default:
            return true
        }
    }
}

