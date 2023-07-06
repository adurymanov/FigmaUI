import Foundation
import UIKit

enum FigmaHTextAlign: String, Decodable {
    case left = "LEFT"
    case right = "RIGHT"
    case center = "CENTER"
    case justified = "JUSTIFIED"
}

extension FigmaHTextAlign {
    
    var nsTextAligment: NSTextAlignment {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        case .center:
            return .center
        case .justified:
            return .justified
        }
    }
    
}
