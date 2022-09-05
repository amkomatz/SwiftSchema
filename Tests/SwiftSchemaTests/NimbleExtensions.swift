import Nimble

func throwError<Out>(_ error: any Error) -> Predicate<Out> {
    return Predicate { actualExpression in
        var actualError: Error?
        do {
            _ = try actualExpression.evaluate()
        } catch {
            actualError = error
        }
        
        let expected = (error as CustomDebugStringConvertible).debugDescription
        
        if let actualError {
            let actual = (actualError as CustomDebugStringConvertible).debugDescription
            return PredicateResult(
                bool: actual == expected,
                message: .expectedCustomValueTo("throw <\(expected)>", actual: "<\(actual)>")
            )
        } else {
            return PredicateResult(
                bool: false,
                message: .expectedCustomValueTo("throw <\(expected)>", actual: "no error")
            )
        }
    }
}

