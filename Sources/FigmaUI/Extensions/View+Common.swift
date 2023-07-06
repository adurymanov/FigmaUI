import UIKit

extension View where Self: Viewable {
    
    public func layout(with properties: FigmaLayoutProperties, designSystem: FigmaDesignSystem) -> UIView {
        guard visible != false else {
            return UIView()
        }
        
        return makeView(with: designSystem)
            .applied(figmaView: self, with: properties)
    }
    
}

extension View {
    
    func properties(with superviewProperties: FigmaLayoutProperties) -> FigmaLayoutProperties {
        FigmaLayoutProperties(
            layoutMode: layoutMode ?? superviewProperties.layoutMode
        )
    }
    
}
