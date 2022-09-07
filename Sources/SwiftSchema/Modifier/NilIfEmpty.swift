import Foundation

@propertyWrapper
public struct NilIfEmpty<T, Wrapped>: OptionalModifier where T: SchemaValue & AnyOptional, T.Value: Collection, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy = .succeed
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func modify(_ value: T.Value?) throws -> T.Value? {
        if let value, value.isEmpty {
            return nil
        }
        return value
    }
}
