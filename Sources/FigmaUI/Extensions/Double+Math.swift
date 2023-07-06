extension Double {
    
    func minus(_ value: Double) -> Double {
        self - value
    }
    
    func plus(_ value: Double) -> Double {
        self + value
    }
    
    func safeDivide(by value: Double) -> Double {
        if value != 0 {
            self / value
        } else {
            0
        }
    }
    
}
