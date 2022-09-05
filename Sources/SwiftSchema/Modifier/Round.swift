import Foundation

@propertyWrapper
public struct Round<T, Wrapped>: Modifier where T: SchemaValue, T.Value: Roundable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        value.round()
    }
}

extension Round where T == T.Value {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail)
    }
}

extension Round where T: AnyOptional {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed)
    }
}

public protocol Roundable {
    func round() -> Self
}

extension Float: Roundable {
    public func round() -> Float {
        Darwin.round(self)
    }
}

extension Double: Roundable {
    public func round() -> Double {
        Darwin.round(self)
    }
}

extension Optional: Roundable where Wrapped: Roundable {
    public func round() -> Self {
        self?.round()
    }
}
