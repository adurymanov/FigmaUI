import Foundation

extension View {
    
    public func first(withName name: String) -> View? {
        if self.name == name {
            return self
        }

        for child in (self as? ContainerView)?.children ?? [] {
            if let resultView = child.view.first(withName: name) {
                return resultView
            }
        }

        return nil
    }
    
}

extension View {
    
    public func first(where predicate: (View) -> Bool) -> View? {
        if predicate(self) {
            return self
        }
        
        for child in (self as? ContainerView)?.children ?? [] {
            if let resultView = child.view.first(where: predicate) {
                return resultView
            }
        }
        
        return nil
    }
    
}

extension View {
    
    public func firstVisibleText() -> String? {
        first(where: ({ $0 is TextView && $0.visible != false }))
            .flatMap { $0 as? TextView }?
            .characters
    }
    
}
