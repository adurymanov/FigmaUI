import UIKit

struct TextView: View, EffectingView, Decodable, VectoredView {
    
    let id: String
    
    let name: String
    
    let absoluteBoundingBox: FigmaAbsoluteBoundingBox
    
    let constraints: FigmaConstraints
    
    let characters: String
    
    let style: FigmaTypeStyle
    
    let preserveRatio: Bool?
    
    let fills: [FigmaPaint]
    
    let effects: [FigmaTypedEffect]
    
    var layoutGrow: FigmaLayoutGrow?
    
    var layoutMode: FigmaLayoutMode?
    
    var layoutAlign: FigmaLayoutAlign?
    
    let textAlignVertical: FigmaTextAlignVertical?
    
    let styles: FigmaViewStyles?
    
    let visible: Bool?
    
}

extension TextView: Viewable {
    
    func makeView(with designSystem: FigmaDesignSystem) -> UIView {
        let label = UILabel()
        label.text = characters
        label.numberOfLines = 0
        label.font = .systemFont(
            ofSize: style.fontSize.cgFloat,
            weight: style.fontWeight.uiWeight
        )
        label.textAlignment = style.textAlignHorizontal.nsTextAligment
        label.textColor = textColor
        
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        label.applied(figmaViewStylesFromView: self, with: designSystem)
        
        let views: [UIView]
        
        switch textAlignVertical {
        case .bottom:
            views = [UIView(), label]
        case .center:
            views = [UIView(), label, UIView()]
        case .top, .none:
            views = [label, UIView()]
        }
        
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.axis = .vertical
        
        return stackView
    }

}

extension TextView {
    
    var textColor: UIColor {
        let solidFill = fills.first(where: { $0.type == .solid })
        
        guard case let .solid(properties) = solidFill else {
            return .clear
        }
        
        return properties.uiColor
    }
    
}
