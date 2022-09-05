import Foundation

@propertyWrapper
public struct Floor<T, Wrapped>: Modifier where T: SchemaValue, T.Value: Floorable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
    }
    
    public func modify(_ value: T.Value) throws -> T.Value {
        value.floor()
    }
}

extension Floor where T == T.Value {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail)
    }
}

extension Floor where T: AnyOptional {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed)
    }
}

public protocol Floorable {
    func floor() -> Self
}

extension Float: Floorable {
    public func floor() -> Float {
        Darwin.floor(self)
    }
}

extension Double: Floorable {
    public func floor() -> Double {
        Darwin.floor(self)
    }
}
