
public protocol Modifier: WrappedFull where In == Out {
    associatedtype Wrapped where Wrapped: WrappedFull, Wrapped.In == Out
    
    var wrappedValue: Wrapped { get set }
    var nilPolicy: NilValidationPolicy { get }
    
    func modify(_ value: In.Value) throws -> Out.Value
}

extension Modifier {
    public func getValue() throws -> In {
        if let value = try wrappedValue.getValue().schemaValue.value {
            return try .init(schemaValue: .nonOptional(value))
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
            try wrappedValue.setValue(.init(schemaValue: .nonOptional(modify(value))))
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
