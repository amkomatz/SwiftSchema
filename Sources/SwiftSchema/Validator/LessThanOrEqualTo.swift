
@propertyWrapper
public class LessThanOrEqualTo<T, Wrapped>: Validator where T: LessThanOrEqualToComparable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    private let max: T
    private let nilPolicy: NilValidationPolicy
    
    public init(wrappedValue: Wrapped, _ max: T, ifNil nilPolicy: NilValidationPolicy = .succeed) {
        self.wrappedValue = wrappedValue
        self.max = max
        self.nilPolicy = nilPolicy
    }
    
    public func validate(_ value: T) throws {
        if !value.isLessThanOrEqualTo(max, nilPolicy: nilPolicy) {
            throw ValidationError(message: "must be less than or equal to \(max).")
        }
    }
}

public protocol LessThanOrEqualToComparable {
    func isLessThanOrEqualTo(_ value: Self, nilPolicy: NilValidationPolicy) -> Bool
}

extension Int: LessThanOrEqualToComparable {
    public func isLessThanOrEqualTo(_ value: Self, nilPolicy: NilValidationPolicy) -> Bool {
        self <= value
    }
}

extension Float: LessThanOrEqualToComparable {
    public func isLessThanOrEqualTo(_ value: Self, nilPolicy: NilValidationPolicy) -> Bool {
        self <= value
    }
}

extension Double: LessThanOrEqualToComparable {
    public func isLessThanOrEqualTo(_ value: Self, nilPolicy: NilValidationPolicy) -> Bool {
        self <= value
    }
}

extension Optional: LessThanOrEqualToComparable where Wrapped: LessThanOrEqualToComparable {
    public func isLessThanOrEqualTo(_ value: Self, nilPolicy: NilValidationPolicy) -> Bool {
        if let self, let value {
            return self.isLessThanOrEqualTo(value, nilPolicy: nilPolicy)
        } else {
            return nilPolicy.rawValue
        }
    }
}
