import Foundation
import UIKit

struct FigmaFontWeight: Decodable {
    let value: Double
}

extension FigmaFontWeight {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Double.self)
        
        self.init(value: value)
    }
    
}

extension FigmaFontWeight {
    
    var uiWeight: UIFont.Weight {
        switch self.value {
        case 100:
            return .thin
        case 300:
            return .light
        case 400:
            return .regular
        case 500:
            return .medium
        case 600:
            return .semibold
        case 700:
            return .bold
        case 900:
            return .black
        default:
            return UIFont.Weight(rawValue: CGFloat(self.value))
        }
    }
    
}
