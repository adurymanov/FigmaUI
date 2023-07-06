import Foundation

public enum FigmaLayoutAlign: String, Decodable {
    case inherit = "INHERIT"
    case stretch = "STRETCH"
    case oldVersion
    
    public init?(rawValue: String) {
        switch rawValue {
        case "INHERIT":
            self = .inherit
        case "STRETCH":
            self = .stretch
        default:
            self = .oldVersion
        }
    }
    
}
