import UIKit

public protocol View: NameProperties {
    
    var id: String { get }
    
    var absoluteBoundingBox: FigmaAbsoluteBoundingBox { get }
    
    var constraints: FigmaConstraints { get }
    
    var name: String { get }
    
    var preserveRatio: Bool? { get }
    
    var layoutAlign: FigmaLayoutAlign? { get }
    
    var layoutMode: FigmaLayoutMode? { get }
    
    var layoutGrow: FigmaLayoutGrow? { get }
    
    var styles: FigmaViewStyles? { get }
    
    var visible: Bool? { get }
    
    func layout(with properties: FigmaLayoutProperties, designSystem: FigmaDesignSystem) -> UIView
    
}

public protocol VectoredView {
    
    var preserveRatio: Bool? { get }
    
}

public protocol ContainerView {
    
    var children: [FigmaTypedView] { get }
    
    var isWithSafeArea: Bool { get }
    
}

public protocol EffectingView {
    
    var effects: [FigmaTypedEffect] { get }
    
}

public protocol Viewable {
    
    func makeView(with designSystem: FigmaDesignSystem) -> UIView
    
}
