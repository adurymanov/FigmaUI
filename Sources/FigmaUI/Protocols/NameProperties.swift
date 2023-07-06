import Foundation

public protocol NameProperties {
    
    var name: String { get }
    
}

extension NameProperties {
    
    public var properties: [String: String] {
        var result: [String: String] = [:]
        
        name
            .replacingOccurrences(of: ", ", with: "&")
            .split(separator: "&")
            .compactMap { element -> (String, String)? in
                let propertyArray = element.split(separator: "=")
                
                return propertyArray.count == 2
                    ? (String(propertyArray[0]), String(propertyArray[1]))
                    : nil
            }
            .forEach { key, value in
                result[key] = value.lowercased()
            }
        
        return result
    }
    
}
