import Foundation
import UIKit

struct SomeEffect: Effect {
    
    func apply(to view: UIView) {}
    
}

extension SomeEffect: Decodable {}
