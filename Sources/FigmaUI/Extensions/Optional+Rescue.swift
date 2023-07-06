extension Optional {
    
    func rescue(_ value: Wrapped) -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return value
        }
    }
    
}
