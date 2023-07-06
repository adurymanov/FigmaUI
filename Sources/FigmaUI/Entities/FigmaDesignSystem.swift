import Foundation

public protocol FigmaDesignSystem {
    
    func fill(by styleId: String) -> FigmaDesignSystemStyle?
    
    func text(by styleId: String) -> FigmaDesignSystemStyle?
    
    func component(with componentId: String) -> FigmaDesignSystemComponent?
    
    func imageURL(for imageKey: String) -> URL?
    
}
