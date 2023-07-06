import UIKit

public enum FigmaLayoutMode: String, Decodable {
    case none = "NONE"
    case horizontal = "HORIZONTAL"
    case vertical = "VERTICAL"
}

extension FigmaLayoutMode {
    
    var axis: NSLayoutConstraint.Axis? {
        switch self {
        case .horizontal:
            return .horizontal
        case .vertical:
            return .vertical
        case .none:
            return .none
        }
    }
    
}
