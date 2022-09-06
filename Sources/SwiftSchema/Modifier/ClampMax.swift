import Foundation

@propertyWrapper
public struct ClampMax<T, Wrapped>: Modifier where T: SchemaValue, T.Value: Comparable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let max: T.Value
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, max: T.Value) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.max = max
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        value > max ? max : value
    }
}

extension ClampMax where T == T.Value {
    public init(wrappedValue: Wrapped, _ max: T.Value) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, max: max)
    }
}

extension ClampMax where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ max: T.Value) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, max: max)
    }
}
