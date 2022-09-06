
enum PlaceholderError: Error {
    case optionalNotAllowed
}

public protocol WrappedIn {
    associatedtype In: SchemaValue
    
    func getValue() throws -> In
    mutating func setValue(_ value: In) throws
}

public protocol WrappedOut {
    associatedtype Out: SchemaValue
}

public protocol WrappedFull: WrappedIn, WrappedOut {
    
}

public enum SchemaValueChoice<T> {
    case nonOptional(T)
    case optional(T?)
    
    var value: T? {
        switch self {
        case .nonOptional(let value):
            return value
        case .optional(let value):
            return value
        }
    }
}

public protocol SchemaValue: WrappedFull where In == Self, Out == Self {
    associatedtype Value
    
    var schemaValue: SchemaValueChoice<Value> { get }
    
    init(schemaValue: SchemaValueChoice<Value>) throws
}

extension SchemaValue where Value == Self {
    public var schemaValue: SchemaValueChoice<Self> {
        .nonOptional(self)
    }
    
    public init(schemaValue: SchemaValueChoice<Self>) throws {
        guard let value = schemaValue.value else {
            throw PlaceholderError.optionalNotAllowed
        }
        self = value
    }
}

extension String: SchemaValue {}
extension Int: SchemaValue {}
extension Float: SchemaValue {}
extension Double: SchemaValue {}
extension Array: SchemaValue where Element: SchemaValue, Element.Value == Element {}

extension Optional: SchemaValue where Wrapped: SchemaValue, Wrapped.Value == Wrapped {
    public typealias Value = Wrapped
    
    public var schemaValue: SchemaValueChoice<Wrapped.Value> {
        .optional(self)
    }
    
    public init(schemaValue: SchemaValueChoice<Wrapped>) throws {
        self = schemaValue.value
    }
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

extension Optional: WrappedIn, WrappedOut, WrappedFull where Wrapped: WrappedFull, Wrapped: SchemaValue, Wrapped.Value == Wrapped {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}

extension Array: WrappedIn, WrappedOut, WrappedFull where Element: WrappedFull, Element: SchemaValue, Element.Value == Element {
    public typealias In = Self
    public typealias Out = Self
    
    public func getValue() throws -> Self {
        self
    }
    
    public mutating func setValue(_ value: Self) throws {
        self = value
    }
}
