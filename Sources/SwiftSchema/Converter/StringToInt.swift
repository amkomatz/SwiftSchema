
public typealias StringToInt<In, Wrapped> = Convert<In, StringToIntConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == String,
    Wrapped: WrappedFull,
    Wrapped.In.Value == Int

public struct StringToIntConverter: PartialConverter {
    public typealias In = String
    public typealias Out = Int
    public typealias Reverse = IntToStringConverter
    
    public init() {}
    
    public func convert(_ value: String?) throws -> Int? {
        if let value {
            return Int(value)
        }
        return nil
    }
}

extension StringToInt where In == String, Out == Int, Converter == StringToIntConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: StringToIntConverter())
    }
}

extension StringToInt where In == String?, Out == Int?, Converter == StringToIntConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: StringToIntConverter())
    }
}
