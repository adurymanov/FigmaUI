import Foundation
import UIKit

enum FigmaPaint {
    
    case solid(properties: SolidProperties)
    
    case gradient(type: GradientType, properties: GradientProperties)
    
    case image(properties: ImageProperties)
    
}

extension FigmaPaint {
    
    enum PaintType: String, Decodable {
        case solid = "SOLID"
        case gradientLinear = "GRADIENT_LINEAR"
        case gradientRadial = "GRADIENT_RADIAL"
        case gradientAngular = "GRADIENT_ANGULAR"
        case gradientDiamond = "GRADIENT_DIAMOND"
        case image = "IMAGE"
    }
    
    struct SolidProperties: Decodable {
        
        let color: FigmaColor
        
        let opacity: Double?
        
    }
    
    struct GradientProperties: Decodable {
        
        let opacity: Double?
        
        let gradientHandlePositions: [FigmaVector]
        
        let gradientStops: [FigmaColorStop]
        
    }
    
    struct ImageProperties: Decodable {
        
        let opacity: Double?
        
        let scaleMode: FigmaScaleMode
        
        let imageRef: String
        
    }
    
}

extension FigmaPaint {
    
    enum GradientType: String {
        case linear, angular, radial, diamond
    }
    
}

extension FigmaPaint: Decodable {
    
    enum TypeCodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypeCodingKeys.self)
        let type = try container.decode(PaintType.self, forKey: .type)
        
        switch type {
        case .solid:
            let properties = try SolidProperties(from: decoder)
            self = .solid(properties: properties)
        case .gradientLinear:
            let properties = try GradientProperties(from: decoder)
            self = .gradient(type: .linear, properties: properties)
        case .gradientRadial:
            let properties = try GradientProperties(from: decoder)
            self = .gradient(type: .radial, properties: properties)
        case .gradientAngular:
            let properties = try GradientProperties(from: decoder)
            self = .gradient(type: .angular, properties: properties)
        case .gradientDiamond:
            let properties = try GradientProperties(from: decoder)
            self = .gradient(type: .diamond, properties: properties)
        case .image:
            let properties = try ImageProperties(from: decoder)
            self = .image(properties: properties)
        }
    }
    
}

extension FigmaPaint {
    
    var type: PaintType {
        switch self {
        case .solid:
            return .solid
        case let .gradient(type, _):
            switch type {
            case .linear:
                return .gradientLinear
            case .angular:
                return .gradientAngular
            case .radial:
                return .gradientRadial
            case .diamond:
                return .gradientDiamond
            }
        case .image:
            return .image
        }
    }
    
}

extension FigmaPaint.SolidProperties {
    
    var uiColor: UIColor {
        color.uiColor.withAlphaComponent((opacity?.cgFloat).rescue(1))
    }
    
}

extension FigmaPaint.GradientProperties {
    
    var startPoint: FigmaVector {
        gradientHandlePositions[0]
    }
    
    var endPoint: FigmaVector {
        gradientHandlePositions[1]
    }
    
    var position: FigmaVector {
        gradientHandlePositions[1]
    }
    
}

extension FigmaPaint.GradientType {
    
    var caGradientType: CAGradientLayerType {
        switch self {
        case .linear:
            return .axial
        case .radial:
            return .radial
        case .angular:
            return .conic
        case .diamond:
            return .axial
        }
    }
    
}
