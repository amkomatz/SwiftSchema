import Foundation

@propertyWrapper
public class Round<T, Wrapped>: Modifier where T: Roundable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func modify(_ value: T) throws -> T {
        value.round()
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
