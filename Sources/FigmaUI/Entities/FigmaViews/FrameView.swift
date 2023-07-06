import Foundation
import UIKit

struct FrameView: View, Decodable, ContainerView, VectoredView {
    
    let id: String
    
    let absoluteBoundingBox: FigmaAbsoluteBoundingBox
    
    let constraints: FigmaConstraints
    
    let backgroundColor: FigmaColor
    
    let fills: [FigmaPaint]
    
    let clipsContent: Bool
    
    var children: [FigmaTypedView]
    
    var name: String
    
    let layoutMode: FigmaLayoutMode?
    
    let itemSpacing: Double?
    
    let preserveRatio: Bool?
    
    var layoutGrow: FigmaLayoutGrow?
    
    let layoutAlign: FigmaLayoutAlign?
    
    let primaryAxisAlignItems: FigmaPrimaryAxisAlignItems?
    
    let counterAxisAlignItems: FigmaCounterAxisAlignItems?
    
    let styles: FigmaViewStyles?
    
    let visible: Bool?
    
    var isWithSafeArea: Bool {
        name == "safe_area" || properties["type"] == "safe_area"
    }
    
}

extension FrameView {
    
    func layout(
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        guard visible != false else {
            return UIView()
        }
        
        let resultView: UIView
        
        switch layoutMode {
        case .vertical, .horizontal:
            resultView = layoutWithStackView(
                with: self.frameProperties(with: properties),
                designSystem: designSystem
            )
        case .some(.none), nil:
            resultView = layoutWithBaseView(
                with: self.frameProperties(with: properties),
                designSystem: designSystem
            )
        }
        
        return resultView
            .applied(figmaView: self, with: properties)
            .applied(figmaViewStylesFromView: self, with: designSystem)
    }
    
}

// MARK: - Helpers

private extension FrameView {
    
    func frameProperties(with superviewProperties: FigmaLayoutProperties) -> FigmaLayoutProperties {
        var properties = self.properties(with: superviewProperties)
        
        properties.layoutMode = layoutMode
        
        return properties
    }
    
    func layoutWithStackView(
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        let stackView = FigmaStackView(frameView: self)
        
        for subview in children.map(\.view) {
            stackView.addFigmaView(
                subview: subview,
                with: properties,
                designSystem: designSystem)
        }
        
        return stackView
    }
    
    func layoutWithBaseView(
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        let view = makeBaseView(with: properties, designSystem: designSystem)

        layoutSubviews(on: view, with: properties, designSystem: designSystem)
        
        return view
    }
    
    private func makeBaseView(
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        let view = UIView.viewWith(fills: fills, designSystem: designSystem)
        
        view.backgroundColor = backgroundColor.uiColor
        view.clipsToBounds = clipsContent
        
        return view
    }
    
}
