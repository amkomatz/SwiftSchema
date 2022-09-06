
@propertyWrapper
public struct NotEmpty<T, Wrapped>: Validator where T: SchemaValue, T.Value: Collection, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
    }
    
    public func validate(_ value: T.Value) throws {
        if value.isEmpty {
            throw ValidationError(message: "must not be empty.")
        }
    }
}

extension NotEmpty where T == T.Value {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail)
    }
}

extension NotEmpty where T: AnyOptional {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed)
    }
}
