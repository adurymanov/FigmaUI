import Foundation

public struct FigmaStyle: Decodable {
    
    public let name: String
    
    public let description: String
    
    public let styleType: StyleType
    
}

extension FigmaStyle {
    
    public enum StyleType: String, Decodable {
        case fill = "FILL"
        case text = "TEXT"
        case unknown
        
        public init?(rawValue: String) {
            switch rawValue {
            case "FILL":
                self = .fill
            case "TEXT":
                self = .text
            default:
                self = .unknown
            }
        }
    }
    
}
