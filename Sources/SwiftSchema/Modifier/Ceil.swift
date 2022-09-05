import Foundation

@propertyWrapper
public struct Ceil<T, Wrapped>: Modifier where T: SchemaValue, T.Value: Ceilable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        value.ceil()
    }
}

extension Ceil where T == T.Value {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail)
    }
}

extension Ceil where T: AnyOptional {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed)
    }
}

public protocol Ceilable {
    func ceil() -> Self
}

extension Float: Ceilable {
    public func ceil() -> Float {
        Darwin.ceil(self)
    }
}

extension Double: Ceilable {
    public func ceil() -> Double {
        Darwin.ceil(self)
    }
}
