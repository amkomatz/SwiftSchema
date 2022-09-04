
public protocol WrappedIn {
    associatedtype In
    
    func getValue() throws -> In
    mutating func setValue(_ value: In) throws
}

public protocol WrappedOut {
    associatedtype Out
}

public protocol WrappedFull: WrappedIn, WrappedOut {
    
}

// MARK: - Primitive Conformance

extension String: WrappedFull {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}

extension Int: WrappedFull {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}

extension Float: WrappedFull {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}

extension Double: WrappedFull {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}

extension Optional: WrappedIn, WrappedOut, WrappedFull where Wrapped: WrappedFull {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}
