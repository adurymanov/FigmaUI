import UIKit

struct InstanceView: View, ContainerView, Decodable {
    
    let id: String
    
    let name: String
    
    let absoluteBoundingBox: FigmaAbsoluteBoundingBox
    
    let constraints: FigmaConstraints
    
    let componentId: String
    
    let children: [FigmaTypedView]
    
    var preserveRatio: Bool?
    
    var layoutAlign: FigmaLayoutAlign?
    
    var layoutMode: FigmaLayoutMode?
    
    var layoutGrow: FigmaLayoutGrow?
    
    let styles: FigmaViewStyles?
    
    let fills: [FigmaPaint]
    
    let cornerRadius: Double?
    
    let visible: Bool?
    
    var isWithSafeArea: Bool {
        false
    }
    
}

extension InstanceView {
    
    var isSystem: Bool {
        properties["type"] == "system"
    }
    
}

extension InstanceView {
    
    func layout(
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        guard visible != false else { return UIView() }
        
        return isSystem
            ? makeSystemView(with: designSystem)
            : commonView(
                with: properties,
                designSystem: designSystem)
    }
    
}

extension InstanceView {
    
    private func commonView(
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) -> UIView {
        let commonView = UIView
            .viewWith(fills: fills, designSystem: designSystem)
            .applied(figmaView: self, with: properties)
            .applied(figmaViewStylesFromView: self, with: designSystem)
        
        commonView.layer.cornerRadius = (cornerRadius?.cgFloat).rescue(0)
        
        layoutSubviews(
            on: commonView,
            with: properties,
            designSystem: designSystem
        )
        
        return commonView
    }
    
    private func makeSystemView(with designSystem: FigmaDesignSystem) -> UIView {
        if let systemView = designSystem
            .component(with: componentId)?.layout(insteadOf: self) {
            return systemView
        }
        
        let conteinerView = FigmaContainerView()
        
        conteinerView.componentId = componentId
        
        return conteinerView
    }
    
}
