import Foundation

@propertyWrapper
public struct ClampLength<T, Wrapped>: Modifier where T: SchemaValue, T.Value: RangeReplaceableCollection, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let max: Int
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, max: Int) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.max = max
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        if value.count > max {
            return T.Value(value.prefix(max))
        }
        return value
    }
}

extension ClampLength where T == T.Value {
    public init(wrappedValue: Wrapped, _ max: Int) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, max: max)
    }
}

extension ClampLength where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ max: Int) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, max: max)
    }
}
