import UIKit
import CoreGraphics

struct FigmaVector: Decodable {
    
    let x, y: Double
    
}

extension FigmaVector {
    
    var cgSize: CGSize {
        CGSize(width: x, height: y)
    }
    
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
    
}
