import UIKit
import Kingfisher

extension UIView {
    
    static func viewWith(fills: [FigmaPaint], designSystem: FigmaDesignSystem) -> UIView {
        let view: UIView
        
        switch fills.first {
        case let .solid(properties):
            view = makeViewWithSolidBackground(properties)
        case let .gradient(type, properties):
            view = makeViewWithGradientBackground(type: type, properties)
        case .image(properties: let properties):
            view = makeViewWithImageBackground(properties, designSystem: designSystem)
        case .none:
            view = UIView()
        }
        
        return view
    }
    
}

// MARK: Helpers

private extension UIView {
    
    static func makeViewWithSolidBackground(_ properties: FigmaPaint.SolidProperties) -> UIView {
        let view = UIView()
        view.backgroundColor = properties.uiColor
        return view
    }
    
    static func makeViewWithImageBackground(
        _ properties: FigmaPaint.ImageProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        let imageView = UIImageView()
        
        imageView.kf.setImage(
            with: designSystem.imageURL(for: properties.imageRef)
        )
        
        imageView.contentMode = properties.scaleMode.uiContentMode
        imageView.layer.opacity = Float(properties.opacity ?? 1)
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    static func makeViewWithGradientBackground(
        type: FigmaPaint.GradientType,
        _ properties: FigmaPaint.GradientProperties
    ) -> UIView {
        let colors = properties
            .gradientStops
            .map(\.color)
            .map(\.uiColor)
        
        let locations = properties
            .gradientStops.map(\.position)
            .map { CGFloat($0) }
        
        let gradientView = FigmaGradientView(
            type: type.caGradientType,
            colors: colors,
            locations: locations,
            startPoint: properties.startPoint.cgPoint,
            endPoint: properties.endPoint.cgPoint
        )
        
        return gradientView
    }
    
}
