import Foundation

public struct FigmaTypedEffect {
    
    let type: EffectType
    
    let effect: Effect
    
}

extension FigmaTypedEffect {
    
    enum EffectType: String, Codable {
        case dropShadow = "DROP_SHADOW"
        case backgroundBlur = "BACKGROUND_BLUR"
        case some
    }
    
}

extension FigmaTypedEffect: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        
        let type = EffectType.from(string: typeString)
        
        switch type {
        case .some:
            self.effect = try SomeEffect(from: decoder)
        case .dropShadow:
            self.effect = try DropShadowEffect(from: decoder)
        case .backgroundBlur:
            self.effect = try BackgroundBlurEffect(from: decoder)
        }
        
        self.type = type
    }
    
}

extension FigmaTypedEffect.EffectType {
    
    static func from(string: String) -> Self {
        Self(rawValue: string) ?? .some
    }
    
}
