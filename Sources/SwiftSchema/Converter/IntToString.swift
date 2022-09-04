
@propertyWrapper
public class IntToString<Wrapped>: Converter where Wrapped: WrappedFull, Wrapped.In == String {
    public typealias In = Int
    public typealias Out = String
    
    public var wrappedValue: Wrapped
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func convert(_ value: Int) throws -> String {
        String(value)
    }
    
    public func convert(_ value: String) throws -> Int {
        Int(value)!
    }
}
