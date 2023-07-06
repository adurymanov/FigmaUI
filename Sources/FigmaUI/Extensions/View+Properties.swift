import Foundation

extension View {
    
    var isVerticalContentHugging: Bool {
        properties["v_hug"] == "true"
    }
    
    var isHorizontalContentHugging: Bool {
        properties["h_hug"] == "true"
    }
    
}
