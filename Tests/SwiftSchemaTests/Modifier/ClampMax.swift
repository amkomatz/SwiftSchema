import XCTest
import Nimble

@testable import SwiftSchema

final class ClampMaxTests: SwiftSchemaTest {
    
    // MARK: - Float
    
    struct FloatRequired: KeyCodable {
        @Key("field_1")
        @ClampMax(2)
        var field1: Float = 0
    }
    
    struct FloatNotRequired: KeyCodable {
        @Key("field_1")
        @ClampMax(2)
        var field1: Float? = nil
    }
    
    func test_decode_requiredFloat_lessThanMax_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredFloat_equalToMax_isCorrect() throws {
        let json = #"{"field_1":2}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_requiredFloat_greaterThanMax_isCorrect() throws {
        let json = #"{"field_1":3}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalFloat_lessThanMax_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalFloat_equalToMax_isCorrect() throws {
        let json = #"{"field_1":2}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalFloat_greaterThanMax_isCorrect() throws {
        let json = #"{"field_1":3}"#

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
    
    // MARK: - Double
    
    struct DoubleRequired: KeyCodable {
        @Key("field_1")
        @ClampMax(2)
        var field1: Double = 0
    }
    
    struct DoubleNotRequired: KeyCodable {
        @Key("field_1")
        @ClampMax(2)
        var field1: Double? = nil
    }
    
    func test_decode_requiredDouble_lessThanMax_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredDouble_equalToMax_isCorrect() throws {
        let json = #"{"field_1":2}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_requiredDouble_greaterThanMax_isCorrect() throws {
        let json = #"{"field_1":3}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalDouble_lessThanMax_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalDouble_equalToMax_isCorrect() throws {
        let json = #"{"field_1":2}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 2
    }
    
    func test_decode_optionalDouble_greaterThanMax_isCorrect() throws {
        let json = #"{"field_1":3}"#

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
