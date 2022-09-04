
extension String: CodingKey {
    public var stringValue: String { self }
    public var intValue: Int? { nil }
    
    public init?(stringValue: String) {
        self = stringValue
    }
    
    public init?(intValue: Int) {
        return nil
    }
}
