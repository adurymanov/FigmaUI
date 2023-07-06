import UIKit

struct DropShadowEffect: Decodable {
    
    let color: FigmaColor
    
    let offset: FigmaVector
    
    let radius: Double
    
    let visible: Bool
    
}

extension DropShadowEffect: Effect {
    
    func apply(to view: UIView) {
        guard visible else { return }
        
        view.layer.shadowColor = color.uiColor.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = offset.cgSize
        view.layer.shadowRadius = CGFloat(radius)
    }
    
}
