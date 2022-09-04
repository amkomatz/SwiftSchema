
public protocol Modifier: WrappedFull where In == Out {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    
    func modify(_ value: In) throws -> Out
}

extension Modifier {
    public func getValue() throws -> In {
        try modify(wrappedValue.getValue())
    }
    
    public mutating func setValue(_ value: In) throws {
        try wrappedValue.setValue(modify(value))
    }
}
