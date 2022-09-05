
public protocol Validator: WrappedFull where In == Out {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    var nilPolicy: NilValidationPolicy { get }
    
    func validate(_ value: In.Value) throws
}

extension Validator {
    public func getValue() throws -> In {
        try wrappedValue.getValue()
    }
    
    public mutating func setValue(_ value: In) throws {
        if let value = value.schemaValue.value {
            try validate(value)
        } else {
            switch nilPolicy {
            case .succeed:
                break
            case .fail:
                throw PlaceholderError.optionalNotAllowed
            }
        }
        
        try wrappedValue.setValue(value)
    }
}
