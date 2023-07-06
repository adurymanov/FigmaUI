import UIKit

final class FigmaGradientView: UIView {
    
    override class var layerClass: AnyClass {
       CAGradientLayer.classForCoder()
    }
    
    init(
        type: CAGradientLayerType,
        colors: [UIColor],
        locations: [CGFloat],
        startPoint: CGPoint,
        endPoint: CGPoint
    ) {
        super.init(frame: .zero)
        
        let gradientLayer = layer as? CAGradientLayer
        
        gradientLayer?.type = type
        gradientLayer?.colors = colors.map(\.cgColor)
        gradientLayer?.locations = locations.map { NSNumber(value: Double($0)) }
        
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
