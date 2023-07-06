import UIKit

extension UIView {
    
    func setHeight(equal figmaView: View) {
        if !figmaView.isVerticalContentHugging {
            heightAnchor
                .constraint(equalToConstant: figmaView.absoluteBoundingBox.height.cgFloat)
                .isActive = true
        }
    }
    
    func setWidth(equal figmaView: View) {
        if !figmaView.isHorizontalContentHugging {
            widthAnchor
                .constraint(equalToConstant: figmaView.absoluteBoundingBox.width.cgFloat)
                .isActive = true
        }
    }
    
}

extension UIView {
    
    struct VConstraints {
        var top: CGFloat?
        var bottom: CGFloat?
        var centerY: CGFloat?
    }
    
    struct HConstraints {
        var leading: CGFloat?
        var trailing: CGFloat?
        var centerX: CGFloat?
    }
    
    func pinToSuperview(with vConstraints: VConstraints, hConstraints: HConstraints) {
        guard let superview = superview else { return }
        
        if let top = vConstraints.top {
            topAnchor.constraint(
                equalTo: superview.topAnchor,
                constant: top
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let bottom = vConstraints.bottom {
            bottomAnchor.constraint(
                equalTo: superview.bottomAnchor,
                constant: bottom
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let centerY = vConstraints.centerY {
            centerYAnchor.constraint(
                equalTo: superview.centerYAnchor,
                constant: centerY
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let leading = hConstraints.leading {
            leadingAnchor.constraint(
                equalTo: superview.leadingAnchor,
                constant: leading
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let trailing = hConstraints.trailing {
            trailingAnchor.constraint(
                equalTo: superview.trailingAnchor,
                constant: trailing
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let centerX = hConstraints.centerX {
            centerXAnchor.constraint(
                equalTo: superview.centerXAnchor,
                constant: centerX
            )
            .with(priority: .required)
            .isActive = true
        }
    }
    
    func pinToSuperviewMargins(with vConstraints: VConstraints, hConstraints: HConstraints) {
        guard let superview = superview else { return }
        
        if let top = vConstraints.top {
            topAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.topAnchor,
                constant: top
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let bottom = vConstraints.bottom {
            bottomAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.bottomAnchor,
                constant: bottom
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let centerY = vConstraints.centerY {
            centerYAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.centerYAnchor,
                constant: centerY
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let leading = hConstraints.leading {
            leadingAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.leadingAnchor,
                constant: leading
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let trailing = hConstraints.trailing {
            trailingAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.trailingAnchor,
                constant: trailing
            )
            .with(priority: .required)
            .isActive = true
        }
        
        if let centerX = hConstraints.centerX {
            centerXAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.centerXAnchor,
                constant: centerX
            )
            .with(priority: .required)
            .isActive = true
        }
    }
    
}
