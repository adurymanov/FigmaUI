import UIKit

extension View where Self: ContainerView & Viewable {
    
    public func layout(with properties: FigmaLayoutProperties, designSystem: FigmaDesignSystem) -> UIView {
        guard visible != false else {
            return UIView()
        }
        
        let view = makeView(with: designSystem)
            .applied(figmaView: self, with: properties)
    
        layoutSubviews(
            on: view,
            with: properties,
            designSystem: designSystem)
        
        return view
    }

}

extension View where Self: ContainerView {
    
    func layoutSubviews(
        on view: UIView,
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) {
        for subview in children.map(\.view) {
            let subviewView = subview.layout(
                with: self.properties(with: properties),
                designSystem: designSystem)
            
            let insets = absoluteBoundingBox.makeInsets(from: subview.absoluteBoundingBox)
            
            subviewView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(subviewView)
            
            let vConstraints: UIView.VConstraints
            let hConstraints: UIView.HConstraints
            
            if (subview as? ContainerView)?.isWithSafeArea == true {
                subviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                subviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                subviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                subviewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                continue
            }
            
            switch subview.constraints.vertical {
            case .top:
                vConstraints = UIView.VConstraints(top: insets.top)
            case .bottom:
                vConstraints = UIView.VConstraints(bottom: -insets.bottom)
            case .topBottom:
                vConstraints = UIView.VConstraints(
                    top: insets.top,
                    bottom: -insets.bottom
                )
            case .center:
                vConstraints = UIView.VConstraints(
                    centerY: subview.absoluteBoundingBox.center.y - absoluteBoundingBox.center.y
                )
            case .scale:
                vConstraints = UIView.VConstraints()
            }
            
            switch subview.constraints.horizontal {
            case .left:
                hConstraints = UIView.HConstraints(leading: insets.left)
            case .right:
                hConstraints = UIView.HConstraints(trailing: -insets.right)
            case .leftRight:
                hConstraints = UIView.HConstraints(
                    leading: insets.left,
                    trailing: -insets.right
                )
            case .center:
                hConstraints = UIView.HConstraints(
                    centerX: absoluteBoundingBox.center.x - subview.absoluteBoundingBox.center.x
                )
            case .scale:
                hConstraints = UIView.HConstraints()
            }

            isWithSafeArea
                ? subviewView.pinToSuperviewMargins(with: vConstraints, hConstraints: hConstraints)
                : subviewView.pinToSuperview(with: vConstraints, hConstraints: hConstraints)
        }
    }
    
}
