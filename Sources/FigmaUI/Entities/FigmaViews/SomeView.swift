import UIKit
import CoreGraphics

public struct SomeView: View, ContainerView {
    
    public let id: String
    
    public let name: String
    
    public let absoluteBoundingBox: FigmaAbsoluteBoundingBox
    
    public let constraints: FigmaConstraints
    
    public let children: [FigmaTypedView]
    
    public var preserveRatio: Bool?
    
    public var layoutAlign: FigmaLayoutAlign?
    
    public var layoutMode: FigmaLayoutMode?
    
    public var layoutGrow: FigmaLayoutGrow?
    
    public let styles: FigmaViewStyles?
    
    public let visible: Bool?
    
    public var isWithSafeArea: Bool {
        false
    }
    
}

extension SomeView: Viewable {
    
    public func makeView(with designSystem: FigmaDesignSystem) -> UIView {
        UIView(frame: .zero).applied(figmaViewStylesFromView: self, with: designSystem)
    }
    
}

extension SomeView: Decodable {

    enum CodingKeys: String, CodingKey {
        case absoluteBoundingBox
        case constraints
        case children
        case name
        case preserveRatio
        case layoutAlign
        case styles
        case visible
        case id
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.absoluteBoundingBox = try container.decode(FigmaAbsoluteBoundingBox.self, forKey: .absoluteBoundingBox)
        self.constraints = try container.decode(FigmaConstraints.self, forKey: .constraints)
        self.children = (try? container.decode([FigmaTypedView].self, forKey: .children)) ?? []
        self.name = try container.decode(String.self, forKey: .name)
        self.preserveRatio = try? container.decode(Bool.self, forKey: .preserveRatio)
        self.layoutAlign = try? container.decode(FigmaLayoutAlign.self, forKey: .layoutAlign)
        self.styles = try? container.decode(FigmaViewStyles.self, forKey: .styles)
        self.visible = try? container.decode(Bool.self, forKey: .visible)
        self.id = try container.decode(String.self, forKey: .id)
    }

}
