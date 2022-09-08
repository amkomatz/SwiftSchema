
public protocol Converter {
    associatedtype In
    associatedtype Out
    
    init()
    
    func convert(_ value: In?) throws -> Out?
    func convert(_ value: Out?) throws -> In?
}

public protocol PartialConverter: Converter {
    associatedtype Reverse: Converter where Reverse.In == Out, Reverse.Out == In
    
    init()
}

extension PartialConverter {
    public func convert(_ value: Out?) throws -> In? {
        try Reverse().convert(value)
    }
}
