import UIKit

struct BackgroundBlurEffect: Decodable {
    
    let radius: Double
    
    let visible: Bool
    
}

extension BackgroundBlurEffect: Effect {
    
    func apply(to view: UIView) {
        guard visible else { return }
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.clipsToBounds = true
        
        view.addSubview(blurEffectView)
    }
    
}
