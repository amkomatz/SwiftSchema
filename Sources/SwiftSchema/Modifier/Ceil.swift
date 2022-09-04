import Foundation

@propertyWrapper
public class Ceil<T, Wrapped>: Modifier where T: Ceilable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func modify(_ value: T) throws -> T {
        value.ceil()
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
