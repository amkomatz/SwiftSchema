
public typealias StringToFloat<In, Wrapped> = Convert<In, StringToFloatConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == String,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Float

public struct StringToFloatConverter: PartialConverter {
    public typealias In = String
    public typealias Out = Float
    public typealias Reverse = FloatToStringConverter
    
    public init() {}
    
    public func convert(_ value: String?) throws -> Float? {
        if let value {
            return Float(value)
        }
        return nil
    }
}

extension StringToFloat where In == String, Out == Float, Converter == StringToFloatConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: StringToFloatConverter())
    }
}

extension StringToFloat where In == String?, Out == Float?, Converter == StringToFloatConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: StringToFloatConverter())
    }
}
