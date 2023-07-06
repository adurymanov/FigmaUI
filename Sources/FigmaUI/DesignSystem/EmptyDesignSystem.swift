import Foundation

public struct EmptyDesignSystem: FigmaDesignSystem {
    
    public func fill(by styleId: String) -> FigmaDesignSystemStyle? { nil }
    
    public func text(by styleId: String) -> FigmaDesignSystemStyle? { nil }
    
    public func component(with componentId: String) -> FigmaDesignSystemComponent? { nil }
    
    public func imageURL(for imageKey: String) -> URL? { nil }
    
    public init() {}
    
}
