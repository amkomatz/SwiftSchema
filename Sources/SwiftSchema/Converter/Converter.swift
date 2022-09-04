
public protocol Converter: WrappedFull {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    
    func convert(_ value: In) throws -> Out
    func convert(_ value: Out) throws -> In
}

extension Converter {
    public func getValue() throws -> In {
        try convert(wrappedValue.getValue())
    }
    
    public mutating func setValue(_ value: In) throws {
        try wrappedValue.setValue(convert(value))
    }
}
