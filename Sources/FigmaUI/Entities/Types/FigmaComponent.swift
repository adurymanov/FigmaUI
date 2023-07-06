import Foundation

public struct FigmaComponent: Decodable, NameProperties {
    
    let key: String
    
    public let name: String
    
    let description: String
    
    let documentationLinks: [URL]
    
}

extension FigmaComponent {
    
    public var componentClass: ComponentClass? {
        properties["class"].flatMap { ComponentClass(rawValue: $0.lowercased()) }
    }
    
}

extension FigmaComponent {
    
    public enum ComponentClass: String {
        case buttons
    }
    
}
