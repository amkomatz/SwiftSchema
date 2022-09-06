import Foundation

@propertyWrapper
public struct ClampMin<T, Wrapped>: Modifier where T: SchemaValue, T.Value: Comparable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let min: T.Value
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, min: T.Value) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.min = min
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        value < min ? min : value
    }
}

extension ClampMin where T == T.Value {
    public init(wrappedValue: Wrapped, _ min: T.Value) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, min: min)
    }
}

extension ClampMin where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ min: T.Value) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, min: min)
    }
}
