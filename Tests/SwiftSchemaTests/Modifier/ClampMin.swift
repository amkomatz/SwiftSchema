import XCTest
import Nimble

@testable import SwiftSchema

final class ClampMinTests: SwiftSchemaTest {
    
    // MARK: - Float
    
    struct FloatRequired: KeyCodable {
        @Key("field_1")
        @ClampMin(1)
        var field1: Float = 0
    }
    
    struct FloatNotRequired: KeyCodable {
        @Key("field_1")
        @ClampMin(1)
        var field1: Float? = nil
    }
    
    func test_decode_requiredFloat_lessThanMin_isCorrect() throws {
        let json = #"{"field_1":0}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredFloat_equalToMin_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredFloat_greaterThanMin_isCorrect() throws {
        let json = #"{"field_1":1.1}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 1.1
    }
    
    func test_decode_optionalFloat_lessThanMin_isCorrect() throws {
        let json = #"{"field_1":0}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalFloat_equalToMin_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalFloat_greaterThanMin_isCorrect() throws {
        let json = #"{"field_1":1.1}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 1.1
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
        @ClampMin(1)
        var field1: Double = 0
    }
    
    struct DoubleNotRequired: KeyCodable {
        @Key("field_1")
        @ClampMin(1)
        var field1: Double? = nil
    }
    
    func test_decode_requiredDouble_lessThanMin_isCorrect() throws {
        let json = #"{"field_1":0}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredDouble_equalToMin_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredDouble_greaterThanMin_isCorrect() throws {
        let json = #"{"field_1":1.1}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 1.1
    }
    
    func test_decode_optionalDouble_lessThanMin_isCorrect() throws {
        let json = #"{"field_1":0}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalDouble_equalToMin_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalDouble_greaterThanMin_isCorrect() throws {
        let json = #"{"field_1":1.1}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 1.1
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
