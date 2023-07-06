import UIKit

extension UIView {
    
    func appliedEffects(from view: View) -> Self {
        (view as? EffectingView).map {
            $0.effects.map(\.effect).forEach { $0.apply(to: self) }
        }
        
        return self
    }
    
}
