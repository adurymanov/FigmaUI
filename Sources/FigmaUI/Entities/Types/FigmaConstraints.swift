import Foundation

public struct FigmaConstraints: Codable {
    
    let vertical: VConstraints
    
    let horizontal: HConstraints
    
}

extension FigmaConstraints {
    
    public enum VConstraints: String, Codable {
        case top = "TOP"
        case bottom = "BOTTOM"
        case topBottom = "TOP_BOTTOM"
        case center = "CENTER"
        case scale = "SCALE"
    }
    
    public enum HConstraints: String, Codable {
        case left = "LEFT"
        case right = "RIGHT"
        case center = "CENTER"
        case leftRight = "LEFT_RIGHT"
        case scale = "SCALE"
    }
    
}
