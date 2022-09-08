
public typealias DoubleToInt<In, Wrapped> = Convert<In, DoubleToIntConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Double,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Int

public struct DoubleToIntConverter: PartialConverter {
    public typealias In = Double
    public typealias Out = Int
    public typealias Reverse = IntToDoubleConverter
    
    public init() {}
    
    public func convert(_ value: Double?) throws -> Int? {
        if let value {
            return Int(value)
        }
        return nil
    }
}

extension DoubleToInt where In == Double, Out == Int, Converter == DoubleToIntConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: DoubleToIntConverter())
    }
}

extension DoubleToInt where In == Double?, Out == Int?, Converter == DoubleToIntConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: DoubleToIntConverter())
    }
}
