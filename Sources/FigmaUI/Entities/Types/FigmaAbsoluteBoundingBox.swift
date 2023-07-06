import UIKit

public struct FigmaAbsoluteBoundingBox: Decodable {
    
    let x, y, height, width: Double
    
}

extension FigmaAbsoluteBoundingBox {
    
    var rect: CGRect {
        CGRect(
            x: x,
            y: y,
            width: width,
            height: height
        )
    }
    
    var center: CGPoint {
        CGPoint(
            x: CGFloat(x.plus(width.safeDivide(by: 2))),
            y: CGFloat(y.plus(height.safeDivide(by: 2)))
        )
    }
    
    func makeInsets(from childrenBounding: FigmaAbsoluteBoundingBox) -> UIEdgeInsets {
        UIEdgeInsets(
            top: CGFloat(childrenBounding.y.minus(self.y)),
            left: CGFloat(childrenBounding.x.minus(self.x)),
            bottom: CGFloat((self.height.plus(self.y)).minus((childrenBounding.height.plus(childrenBounding.y)))),
            right: CGFloat((self.width.plus(self.x)).minus((childrenBounding.width.plus(childrenBounding.x))))
        )
    }
    
}
