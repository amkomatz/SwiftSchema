
@propertyWrapper
public class LessThanOrEqualTo<T, Wrapped>: Validator where T: SchemaValue, T.Value: Comparable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    private let max: T.Value
    public let nilPolicy: NilValidationPolicy
    
    public init(wrappedValue: Wrapped, _ max: T.Value, ifNil nilPolicy: NilValidationPolicy = .succeed) {
        self.wrappedValue = wrappedValue
        self.max = max
        self.nilPolicy = nilPolicy
    }
    
    public func validate(_ value: T.Value) throws {
        if !(value <= max) {
            throw ValidationError(message: "must be less than or equal to \(max).")
        }
    }
}
