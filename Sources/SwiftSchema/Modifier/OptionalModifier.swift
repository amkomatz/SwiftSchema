
public protocol OptionalModifier: WrappedFull where In == Out {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    
    func modify(_ value: In.Value?) throws -> Out.Value?
}

extension OptionalModifier {
    public func getValue() throws -> In {
        try .init(schemaValue: .optional(wrappedValue.getValue().schemaValue.value))
    }
    
    public mutating func setValue(_ value: In) throws {
        try wrappedValue.setValue(.init(schemaValue: .optional(modify(value.schemaValue.value))))
    }
}
