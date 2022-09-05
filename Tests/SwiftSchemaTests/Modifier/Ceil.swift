import XCTest
import Nimble

@testable import SwiftSchema

final class CeilTests: SwiftSchemaTest {
    struct FloatRequired: KeyCodable {
        @Key("field_1")
        @Ceil
        var field1: Float = 0
    }
    
    struct FloatNotRequired: KeyCodable {
        @Key("field_1")
        @Ceil
        var field1: Float? = nil
    }
    
    struct DoubleRequired: KeyCodable {
        @Key("field_1")
        @Ceil
        var field1: Double = 0
    }
    
    struct DoubleNotRequired: KeyCodable {
        @Key("field_1")
        @Ceil
        var field1: Double? = nil
    }
    
    func test_decode_requiredFloat_wholeNumberInJson_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredFloat_fractionInJson_isCorrect() throws {
        let json = #"{"field_1":1.2}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalFloat_wholeNumberInJson_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalFloat_fractionInJson_isCorrect() throws {
        let json = #"{"field_1":1.2}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalFloat_nilInJson_isCorrect() throws {
        let json = #"{"field_1":null}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    func test_decode_optionalFloat_missingInJson_isCorrect() throws {
        let json = #"{"other_field":null}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    func test_decode_requiredDouble_wholeNumberInJson_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredDouble_fractionInJson_isCorrect() throws {
        let json = #"{"field_1":1.2}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalDouble_wholeNumberInJson_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalDouble_fractionInJson_isCorrect() throws {
        let json = #"{"field_1":1.2}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalDouble_nilInJson_isCorrect() throws {
        let json = #"{"field_1":null}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    func test_decode_optionalDouble_missingInJson_isCorrect() throws {
        let json = #"{"other_field":null}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
}
