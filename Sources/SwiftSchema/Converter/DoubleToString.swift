
public typealias DoubleToString<In, Wrapped> = Convert<In, DoubleToStringConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Double,
    Wrapped: WrappedFull,
    Wrapped.In.Value == String

public struct DoubleToStringConverter: PartialConverter {
    public typealias In = Double
    public typealias Out = String
    public typealias Reverse = StringToDoubleConverter
    
    public init() {}
    
    public func convert(_ value: Double?) throws -> String? {
        if let value {
            return String(value)
        }
        return nil
    }
}

extension DoubleToString where In == Double, Out == String, Converter == DoubleToStringConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: DoubleToStringConverter())
    }
}

extension DoubleToString where In == Double?, Out == String?, Converter == DoubleToStringConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: DoubleToStringConverter())
    }
}
