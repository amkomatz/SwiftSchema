
public typealias FloatToInt<In, Wrapped> = Convert<In, FloatToIntConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Float,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Int

public struct FloatToIntConverter: PartialConverter {
    public typealias In = Float
    public typealias Out = Int
    public typealias Reverse = IntToFloatConverter
    
    public init() {}
    
    public func convert(_ value: Float?) throws -> Int? {
        if let value {
            return Int(value)
        }
        return nil
    }
}

extension FloatToInt where In == Float, Out == Int, Converter == FloatToIntConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: FloatToIntConverter())
    }
}

extension FloatToInt where In == Float?, Out == Int?, Converter == FloatToIntConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: FloatToIntConverter())
    }
}
