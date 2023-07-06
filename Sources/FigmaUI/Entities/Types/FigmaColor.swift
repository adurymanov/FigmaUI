import UIKit

public struct FigmaColor: Decodable {
    
    // swiftlint:disable identifier_name
    let r, g, b, a: Double
    // swiftlint:enable identifier_name
    
}

extension FigmaColor {
    
    var uiColor: UIColor {
        UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
}
