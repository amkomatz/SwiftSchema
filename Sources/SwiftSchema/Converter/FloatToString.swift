
public typealias FloatToString<In, Wrapped> = Convert<In, FloatToStringConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Float,
    Wrapped: WrappedFull,
    Wrapped.In.Value == String

public struct FloatToStringConverter: PartialConverter {
    public typealias In = Float
    public typealias Out = String
    public typealias Reverse = StringToFloatConverter
    
    public init() {}
    
    public func convert(_ value: Float?) throws -> String? {
        if let value {
            return String(value)
        }
        return nil
    }
}

extension FloatToString where In == Float, Out == String, Converter == FloatToStringConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: FloatToStringConverter())
    }
}

extension FloatToString where In == Float?, Out == String?, Converter == FloatToStringConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: FloatToStringConverter())
    }
}
