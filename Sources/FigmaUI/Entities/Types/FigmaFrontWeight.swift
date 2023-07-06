import Foundation
import UIKit

enum FigmaFrontWeight: Double, Decodable {
    case thin = 100
    case light = 300
    case regular = 400
    case medium = 500
    case semiBold = 600
    case bold = 700
    case black = 900
}

extension FigmaFrontWeight {
    
    var uiWeight: UIFont.Weight {
        switch self {
        case .thin:
            return .thin
        case .light:
            return .light
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semiBold:
            return .semibold
        case .bold:
            return .bold
        case .black:
            return .black
        }
    }
    
}
