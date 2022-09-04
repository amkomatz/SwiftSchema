
public protocol Validator: WrappedFull where In == Out {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    
    func validate(_ value: In) throws
}

extension Validator {
    public func getValue() throws -> In {
        try wrappedValue.getValue()
    }
    
    public mutating func setValue(_ value: In) throws {
        try validate(value)
        try wrappedValue.setValue(value)
    }
}
