
@propertyWrapper
public struct MaxLength<T, Wrapped>: Validator where T: SchemaValue, T.Value: Collection, Wrapped: WrappedFull, Wrapped.In == T {
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
    
    public func validate(_ value: T.Value) throws {
        if value.count > max {
            throw ValidationError(message: "must contain less than \(max) elements.")
        }
    }
}

extension MaxLength where T == T.Value {
    public init(wrappedValue: Wrapped, _ max: Int) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, max: max)
    }
}

extension MaxLength where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ max: Int) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, max: max)
    }
}
