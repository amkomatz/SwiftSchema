
@propertyWrapper
public class StringToInt<Wrapped>: Converter where Wrapped: WrappedFull, Wrapped.In == Int {
    public typealias In = String
    public typealias Out = Int
    
    public var wrappedValue: Wrapped
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func convert(_ value: String) throws -> Int {
        Int(value)!
    }
    
    public func convert(_ value: Int) throws -> String {
        String(value)
    }
}
