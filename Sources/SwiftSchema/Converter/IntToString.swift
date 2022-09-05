
@propertyWrapper
public struct IntToString<In, Wrapped>: Converter where In: SchemaValue, In.Value == Int, Wrapped: WrappedFull, Wrapped.In: SchemaValue, Wrapped.In.Value == String {
    public typealias Out = Wrapped.In
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
    }
    
    public func convert(_ value: Int) throws -> String {
        String(value)
    }
    
    public func convert(_ value: String) throws -> Int {
        guard let int = Int(value) else {
            throw Exception.invalidIntegerString
        }
        return int
    }
    
    public enum Exception: Error {
        case invalidIntegerString
    }
}

extension IntToString where In == Int, Out == String {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail)
    }
}

extension IntToString where In == Int?, Out == String? {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed)
    }
}
