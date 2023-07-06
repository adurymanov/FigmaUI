import UIKit

public protocol FigmaDesignSystemStyle {
    
    func apply(to view: UIView)
    
}

extension UIView {
    
    @discardableResult
    public func applyFigmaStyle(_ style: FigmaDesignSystemStyle) -> Self {
        style.apply(to: self)
        return self
    }
    
    @discardableResult
    public func applyFigmaStyles(_ styles: [FigmaDesignSystemStyle]) -> Self {
        styles.forEach { applyFigmaStyle($0) }
        return self
    }
    
}
