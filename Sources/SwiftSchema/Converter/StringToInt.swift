
@propertyWrapper
public struct StringToInt<In, Wrapped>: Converter where In: SchemaValue, In.Value == String, Wrapped: WrappedFull, Wrapped.In: SchemaValue, Wrapped.In.Value == Int {
    public typealias Out = Wrapped.In
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
    }
    
    public func convert(_ value: String) throws -> Int {
        Int(value)!
    }
    
    public func convert(_ value: Int) throws -> String {
        String(value)
    }
}

extension StringToInt where In == String, Out == Int {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail)
    }
}

extension StringToInt where In == String?, Out == Int? {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed)
    }
}
