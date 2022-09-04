import Foundation

@propertyWrapper
public class Floor<T, Wrapped>: Modifier where T: Floorable, Wrapped: WrappedFull, Wrapped.In == T {
    public typealias In = T
    public typealias Out = T
    
    public var wrappedValue: Wrapped
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func modify(_ value: T) throws -> T {
        value.floor()
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
