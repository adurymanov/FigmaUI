import Foundation

public struct FigmaDocument: Decodable {
    
    public let document: DocumentView
    
    public let components: [String: FigmaComponent]
    
    public let styles: [String: FigmaStyle]
    
}

extension FigmaDocument {
    
    public struct DocumentView: Decodable {
        
        let children: [CanvasView]
        
    }
    
}

extension FigmaDocument.DocumentView {
    
    public struct CanvasView: Decodable {
        
        let children: [FigmaTypedView]
        
    }
    
}

extension FigmaDocument.DocumentView {
    
    public func firstView(withName name: String) -> View? {
        for typedView in children.first?.children ?? [] {
            if let result = typedView.view.first(withName: name) {
                return result
            }
        }
        return nil
    }
    
}
