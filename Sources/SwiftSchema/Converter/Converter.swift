
public protocol Converter: WrappedFull {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    var nilPolicy: NilValidationPolicy { get }
    
    func convert(_ value: In.Value) throws -> Out.Value
    func convert(_ value: Out.Value) throws -> In.Value
}

extension Converter {
    public func getValue() throws -> In {
        if let value = try wrappedValue.getValue().schemaValue.value {
            return try .init(schemaValue: .nonOptional(convert(value)))
        } else {
            switch nilPolicy {
            case .succeed:
                return try In(schemaValue: .optional(nil))
            case .fail:
                throw PlaceholderError.optionalNotAllowed
            }
        }
    }
    
    public mutating func setValue(_ value: In) throws {
        if let value = value.schemaValue.value {
            try wrappedValue.setValue(.init(schemaValue: .nonOptional(convert(value))))
        } else {
            switch nilPolicy {
            case .succeed:
                try wrappedValue.setValue(.init(schemaValue: .optional(nil)))
            case .fail:
                throw PlaceholderError.optionalNotAllowed
            }
        }
    }
}
