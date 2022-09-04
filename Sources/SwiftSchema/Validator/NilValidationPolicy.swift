
public enum NilValidationPolicy {
    case succeed
    case fail
    
    public var rawValue: Bool {
        switch self {
        case .succeed: return true
        case .fail: return false
        }
    }
}
