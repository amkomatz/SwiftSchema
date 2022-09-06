
@propertyWrapper
public struct MinLength<T, Wrapped>: Validator where T: SchemaValue, T.Value: Collection, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let min: Int
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, min: Int) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.min = min
    }
    
    public func validate(_ value: T.Value) throws {
        if value.count < min {
            throw ValidationError(message: "must contain at least \(min) elements.")
        }
    }
}

extension MinLength where T == T.Value {
    public init(wrappedValue: Wrapped, _ min: Int) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, min: min)
    }
}

extension MinLength where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ min: Int) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, min: min)
    }
}
