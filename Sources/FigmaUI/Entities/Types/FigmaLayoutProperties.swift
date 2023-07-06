import Foundation

public struct FigmaLayoutProperties {
    
    var layoutMode: FigmaLayoutMode?
    
}

public extension FigmaLayoutProperties {
    
    static var empty: Self {
        FigmaLayoutProperties()
    }
    
}
