
public typealias StringToDouble<In, Wrapped> = Convert<In, StringToDoubleConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == String,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Double

public struct StringToDoubleConverter: PartialConverter {
    public typealias In = String
    public typealias Out = Double
    public typealias Reverse = DoubleToStringConverter
    
    public init() {}
    
    public func convert(_ value: String?) throws -> Double? {
        if let value {
            return Double(value)
        }
        return nil
    }
}

extension StringToDouble where In == String, Out == Double, Converter == StringToDoubleConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: StringToDoubleConverter())
    }
}

extension StringToDouble where In == String?, Out == Double?, Converter == StringToDoubleConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: StringToDoubleConverter())
    }
}
