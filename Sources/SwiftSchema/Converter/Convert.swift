
@propertyWrapper
public struct Convert<In, Converter, Wrapped>: WrappedFull where
    Converter: SwiftSchema.Converter,
    In: SchemaValue,
    In.Value == Converter.In,
    Wrapped: WrappedFull,
    Wrapped.In: SchemaValue,
    Wrapped.In.Value == Converter.Out
{
    public typealias Out = Wrapped.In
    
    public var wrappedValue: Wrapped
    public let nilPolicy: NilValidationPolicy
    private let converter: Converter
    
    internal init(wrappedValue: Wrapped, nilPolicy: NilValidationPolicy, converter: Converter) {
        self.wrappedValue = wrappedValue
        self.nilPolicy = nilPolicy
        self.converter = converter
    }
    
    public func getValue() throws -> In {
        let converted = try converter.convert(wrappedValue.getValue().schemaValue.value)
        
        if let converted {
            return try .init(schemaValue: .nonOptional(converted))
        } else {
            switch nilPolicy {
            case .succeed:
                return try In(schemaValue: .optional(converted))
            case .fail:
                throw ValidationError(message: "unable to convert \(Out.self) to \(In.self).")
            }
        }
    }
    
    public mutating func setValue(_ value: In) throws {
        let converted = try converter.convert(value.schemaValue.value)
        
        if let converted {
            try wrappedValue.setValue(.init(schemaValue: .nonOptional(converted)))
        } else {
            switch nilPolicy {
            case .succeed:
                try wrappedValue.setValue(.init(schemaValue: .optional(converted)))
            case .fail:
                throw ValidationError(message: "unable to convert \(In.self) to \(Out.self).")
            }
        }
    }
    
    public enum Exception: Error {
        case invalidIntegerString
    }
}
