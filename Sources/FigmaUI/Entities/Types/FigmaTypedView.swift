import Foundation

public struct FigmaTypedView {
    public let type: ViewType
    public let view: View
}

extension FigmaTypedView {
    
    public enum ViewType: String, Codable {
        case text = "TEXT"
        case frame = "FRAME"
        case rectangle = "RECTANGLE"
        case instance = "INSTANCE"
        case some
    }
    
}

extension FigmaTypedView: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        
        let type = ViewType.from(string: typeString)
        
        switch type {
        case .some:
            self.view = try SomeView(from: decoder)
        case .frame:
            self.view = try FrameView(from: decoder)
        case .text:
            self.view = try TextView(from: decoder)
        case .rectangle:
            self.view = try RectangleView(from: decoder)
        case .instance:
            self.view = try InstanceView(from: decoder)
        }
        
        self.type = type
    }
    
}

extension FigmaTypedView.ViewType {
    
    static func from(string: String) -> Self {
        Self(rawValue: string) ?? .some
    }
    
}
