
public typealias IntToFloat<In, Wrapped> = Convert<In, IntToFloatConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Int,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Float

public struct IntToFloatConverter: PartialConverter {
    public typealias In = Int
    public typealias Out = Float
    public typealias Reverse = FloatToIntConverter
    
    public init() {}
    
    public func convert(_ value: Int?) throws -> Float? {
        if let value {
            return Float(value)
        }
        return nil
    }
}

extension IntToFloat where In == Int, Out == Float, Converter == IntToFloatConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: IntToFloatConverter())
    }
}

extension IntToFloat where In == Int?, Out == Float?, Converter == IntToFloatConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: IntToFloatConverter())
    }
}
