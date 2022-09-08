
public typealias IntToString<In, Wrapped> = Convert<In, IntToStringConverter, Wrapped> where
    In: SchemaValue & WrappedFull,
    In.Value == Int,
    Wrapped: WrappedFull,
    Wrapped.In.Value == String

public struct IntToStringConverter: PartialConverter {
    public typealias In = Int
    public typealias Out = String
    public typealias Reverse = StringToIntConverter
    
    public init() {}
    
    public func convert(_ value: Int?) throws -> String? {
        if let value {
            return String(value)
        }
        return nil
    }
}

extension IntToString where In == Int, Out == String, Converter == IntToStringConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .fail, converter: IntToStringConverter())
    }
}

extension IntToString where In == Int?, Out == String?, Converter == IntToStringConverter {
    public init(wrappedValue: Wrapped) {
        self.init(wrappedValue: wrappedValue, nilPolicy: .succeed, converter: IntToStringConverter())
    }
}
