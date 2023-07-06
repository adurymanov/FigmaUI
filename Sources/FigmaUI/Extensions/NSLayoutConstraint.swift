import UIKit

extension NSLayoutConstraint {
    
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
    
}
