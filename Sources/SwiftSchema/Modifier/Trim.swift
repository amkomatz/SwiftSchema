import Foundation

@propertyWrapper
public struct Trim<T, Wrapped>: Modifier where T: SchemaValue, T.Value == String, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let characters: CharacterSet
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, characters: CharacterSet) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.characters = characters
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        value.trimmingCharacters(in: characters)
    }
}

extension Trim where T == T.Value {
    public init(wrappedValue: Wrapped, _ characters: CharacterSet = .whitespacesAndNewlines) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, characters: characters)
    }
}

extension Trim where T: AnyOptional {
    public init(wrappedValue: Wrapped, _ characters: CharacterSet = .whitespacesAndNewlines) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, characters: characters)
    }
}
