import UIKit

extension UIView {
    
    @discardableResult
    func applied(figmaViewStylesFromView view: View, with designSystem: FigmaDesignSystem) -> Self {
        guard let viewStyles = view.styles else {
            return self
        }
        
        let styles = [
            viewStyles.fill.flatMap { designSystem.fill(by: $0) },
            viewStyles.text.flatMap { designSystem.text(by: $0) }
        ]
        .compactMap { $0 }
        
        applyFigmaStyles(styles)
        
        return self
    }
    
    func applied(figmaView: View, with properties: FigmaLayoutProperties) -> Self {
        let view = self.appliedEffects(from: figmaView)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.preservesSuperviewLayoutMargins = true
        
        view.perform(
            preserveRatio: figmaView.preserveRatio,
            with: figmaView.absoluteBoundingBox
        )
        
        if let layoutAlign = figmaView.layoutAlign, let layoutGrow = figmaView.layoutGrow {
            view.perform(
                layoutAlign: layoutAlign,
                with: properties,
                absoluteBoundingBox: figmaView.absoluteBoundingBox,
                figmaView: figmaView
            )
            view.perform(
                layoutGrow: layoutGrow,
                with: properties,
                absoluteBoundingBox: figmaView.absoluteBoundingBox,
                figmaView: figmaView
            )
        } else {
            setWidth(equal: figmaView)
            setHeight(equal: figmaView)
        }
        
        return view
    }
    
    func perform(preserveRatio: Bool?, with absoluteBoundingBox: FigmaAbsoluteBoundingBox) {
        guard preserveRatio == true else {
            return
        }
        
        widthAnchor
            .constraint(
                equalTo: heightAnchor,
                multiplier: (absoluteBoundingBox.width / absoluteBoundingBox.height).cgFloat
            )
            .isActive = true
    }
    
    func perform(
        layoutAlign: FigmaLayoutAlign,
        with properties: FigmaLayoutProperties,
        absoluteBoundingBox: FigmaAbsoluteBoundingBox,
        figmaView: View
    ) {
        guard let layoutMode = properties.layoutMode else {
            return
        }
        
        switch (layoutAlign, layoutMode) {
        case (.inherit, .horizontal):
            setHeight(equal: figmaView)
        case (.inherit, .vertical):
            setWidth(equal: figmaView)
        case (.stretch, _), (.inherit, .none), (.oldVersion, _):
            break
        }
    }
    
    func perform(
        layoutGrow: FigmaLayoutGrow,
        with properties: FigmaLayoutProperties,
        absoluteBoundingBox: FigmaAbsoluteBoundingBox,
        figmaView: View
    ) {
        guard
            let layoutMode = properties.layoutMode
        else {
            return
        }
        
        switch (layoutGrow, layoutMode) {
        case (.fixed, .horizontal):
            setWidth(equal: figmaView)
        case (.fixed, .vertical):
            setHeight(equal: figmaView)
        case (_, .none):
            setHeight(equal: figmaView)
            setWidth(equal: figmaView)
        case (.stretch, .horizontal), (.stretch, .vertical):
            break
        }
    }
    
}
