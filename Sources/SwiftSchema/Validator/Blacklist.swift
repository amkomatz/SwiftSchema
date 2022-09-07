import Foundation

@propertyWrapper
public struct Blacklist<T, Wrapped>: Validator where T: SchemaValue, T.Value == String, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let blacklist: CharacterSet
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, blacklist: CharacterSet) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.blacklist = blacklist
    }
    
    public func validate(_ value: T.Value) throws {
        if value.unicodeScalars.contains(where: blacklist.contains) {
            throw ValidationError(message: "has invalid characters.")
        }
    }
}

extension Blacklist where T == T.Value {
    public init(wrappedValue: Wrapped, _ blacklist: CharacterSet) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, blacklist: blacklist)
    }
}

extension Blacklist where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ blacklist: CharacterSet) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, blacklist: blacklist)
    }
}
