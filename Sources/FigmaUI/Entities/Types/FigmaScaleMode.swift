import UIKit

enum FigmaScaleMode: String, Decodable {
    case fill = "FILL"
    case fit = "FIT"
    case tile = "TILE"
    case stretch = "STRETCH"
}

extension FigmaScaleMode {
    
    var uiContentMode: UIView.ContentMode {
        switch self {
        case .fill:
            return .scaleAspectFill
        case .fit:
            return .scaleAspectFit
        case .tile:
            return .topRight
        case .stretch:
            return .topRight
        }
    }
    
}
