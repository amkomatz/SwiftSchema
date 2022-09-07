import Foundation

@propertyWrapper
public struct Whitelist<T, Wrapped>: Validator where T: SchemaValue, T.Value == String, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let whitelist: CharacterSet
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, whitelist: CharacterSet) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.whitelist = whitelist
    }
    
    public func validate(_ value: T.Value) throws {
        if !value.unicodeScalars.allSatisfy(whitelist.contains) {
            throw ValidationError(message: "has invalid characters.")
        }
    }
}

extension Whitelist where T == T.Value {
    public init(wrappedValue: Wrapped, _ whitelist: CharacterSet) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, whitelist: whitelist)
    }
}

extension Whitelist where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ whitelist: CharacterSet) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, whitelist: whitelist)
    }
}
