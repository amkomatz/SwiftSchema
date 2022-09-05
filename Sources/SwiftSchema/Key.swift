
public protocol Keyed: AnyObject {
    var key: String { get }
    
    func decode(from container: KeyedDecodingContainer<String>) throws
    func encode(to container: inout KeyedEncodingContainer<String>) throws
}

@propertyWrapper
public class Key<In, Wrapped>: Keyed where In: Codable, Wrapped: WrappedFull, Wrapped.In == In {
    public typealias Out = In
    
    public var wrappedValue: Wrapped
    public let key: String
    
    public init(wrappedValue: Wrapped, type: In.Type = In.self, _ key: String) {
        self.wrappedValue = wrappedValue
        self.key = key
    }
    
    public func decode(from container: KeyedDecodingContainer<String>) throws {
        let value = try _decode(from: container)
        try wrappedValue.setValue(value)
    }
    
    private func _decode(from container: KeyedDecodingContainer<String>) throws -> In {
        if let type = In.self as? _Optional.Type {
            return try type.decode(from: container, key: key) as! In
        } else {
            return try container.decode(In.self, forKey: key)
        }
    }
    
    public func encode(to container: inout KeyedEncodingContainer<String>) throws {
        try container.encode(wrappedValue.getValue(), forKey: key)
    }
}

internal protocol _Optional {
    static func decode(from container: KeyedDecodingContainer<String>, key: String) throws -> Self
}

extension Optional: _Optional where Wrapped: Decodable {
    static func decode(from container: KeyedDecodingContainer<String>, key: String) throws -> Self {
        try container.decodeIfPresent(Wrapped.self, forKey: key)
    }
}

public protocol AnyOptional {
    
}

extension Optional: AnyOptional {}
