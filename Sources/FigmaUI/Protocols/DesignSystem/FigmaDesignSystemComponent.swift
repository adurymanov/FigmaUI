import UIKit

public protocol FigmaDesignSystemComponent {
    
    func layout(insteadOf figmaView: View) -> UIView
    
}
