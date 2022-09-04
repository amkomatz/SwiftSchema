
public protocol KeyCodable: Codable {
    init()
}

extension KeyCodable {
    public var keys: [any Keyed] {
        Mirror(reflecting: self).children.compactMap {
            $0.value as? Keyed
        }
    }
    
    public init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: String.self)
        
        let keys = self.keys
        try keys.forEach { key in
            try key.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: String.self)
        
        try keys.forEach { key in
            try key.encode(to: &container)
        }
    }
}
