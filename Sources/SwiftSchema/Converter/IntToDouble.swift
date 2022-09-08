
public typealias IntToDouble<In, Wrapped> = Convert<In, IntToDoubleConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Int,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Double

public struct IntToDoubleConverter: PartialConverter {
    public typealias In = Int
    public typealias Out = Double
    public typealias Reverse = DoubleToIntConverter
    
    public init() {}
    
    public func convert(_ value: Int?) throws -> Double? {
        if let value {
            return Double(value)
        }
        return nil
    }
}

extension IntToDouble where In == Int, Out == Double, Converter == IntToDoubleConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: IntToDoubleConverter())
    }
}

extension IntToDouble where In == Int?, Out == Double?, Converter == IntToDoubleConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: IntToDoubleConverter())
    }
}
