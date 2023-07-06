import Foundation
import UIKit

struct RectangleView: View, EffectingView, Decodable, VectoredView {
    
    let id: String
    
    var name: String
    
    let absoluteBoundingBox: FigmaAbsoluteBoundingBox
    
    let constraints: FigmaConstraints
    
    let fills: [FigmaPaint]
    
    let cornerRadius: Double?
    
    let preserveRatio: Bool?
    
    let layoutAlign: FigmaLayoutAlign?
    
    var layoutMode: FigmaLayoutMode?
    
    var layoutGrow: FigmaLayoutGrow?
    
    let effects: [FigmaTypedEffect]
    
    let styles: FigmaViewStyles?
    
    let visible: Bool?
    
}

extension RectangleView: Viewable {
    
    func makeView(with designSystem: FigmaDesignSystem) -> UIView {
        let view = UIView
            .viewWith(fills: fills, designSystem: designSystem)
            .applied(figmaViewStylesFromView: self, with: designSystem)
        
        view.layer.cornerRadius = (cornerRadius?.cgFloat).rescue(0)
        
        return view
    }
    
}
