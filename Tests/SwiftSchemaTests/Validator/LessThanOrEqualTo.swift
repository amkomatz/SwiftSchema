import XCTest
import Nimble

@testable import SwiftSchema

final class LessThanOrEqualToTests: SwiftSchemaTest {
    
    // MARK: - Int
    
    struct IntRequired: KeyCodable {
        @Key("field_1")
        @LessThanOrEqualTo(5)
        var field1: Int = 0
    }
    
    struct IntNotRequired: KeyCodable {
        @Key("field_1")
        @LessThanOrEqualTo(5)
        var field1: Int? = nil
    }
    
    func test_decode_requiredInt_lessThan_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(IntRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredInt_equalTo_isCorrect() throws {
        let json = #"{"field_1":5}"#

        let decoded = try decode(IntRequired.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_requiredInt_greaterThan_isCorrect() throws {
        let json = #"{"field_1":6}"#

        expect(try self.decode(IntRequired.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.")))
    }
    
    func test_decode_optionalInt_lessThan_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(IntNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalInt_equalTo_isCorrect() throws {
        let json = #"{"field_1":5}"#

        let decoded = try decode(IntNotRequired.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_optionalInt_greaterThan_isCorrect() throws {
        let json = #"{"field_1":6}"#

        expect(try self.decode(IntNotRequired.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.")))
    }
    
    func test_decode_optionalInt_nilInJson_isCorrect() throws {
        let json = #"{"field_1":null}"#

        let decoded = try decode(IntNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    func test_decode_optionalInt_missingInJson_isCorrect() throws {
        let json = #"{"other_field":null}"#

        let decoded = try decode(IntNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    // MARK: - Float
    
    struct FloatRequired: KeyCodable {
        @Key("field_1")
        @LessThanOrEqualTo(5)
        var field1: Float = 0
    }
    
    struct FloatNotRequired: KeyCodable {
        @Key("field_1")
        @LessThanOrEqualTo(5)
        var field1: Float? = nil
    }
    
    func test_decode_requiredFloat_lessThan_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredFloat_equalTo_isCorrect() throws {
        let json = #"{"field_1":5}"#

        let decoded = try decode(FloatRequired.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_requiredFloat_greaterThan_isCorrect() throws {
        let json = #"{"field_1":5.1}"#

        expect(try self.decode(FloatRequired.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.0.")))
    }
    
    func test_decode_optionalFloat_lessThan_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalFloat_equalTo_isCorrect() throws {
        let json = #"{"field_1":5}"#

        let decoded = try decode(FloatNotRequired.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_optionalFloat_greaterThan_isCorrect() throws {
        let json = #"{"field_1":5.1}"#

        expect(try self.decode(FloatNotRequired.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.0.")))
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
        @LessThanOrEqualTo(5)
        var field1: Double = 0
    }
    
    struct DoubleNotRequired: KeyCodable {
        @Key("field_1")
        @LessThanOrEqualTo(5)
        var field1: Double? = nil
    }
    
    func test_decode_requiredDouble_lessThan_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_requiredDouble_equalTo_isCorrect() throws {
        let json = #"{"field_1":5}"#

        let decoded = try decode(DoubleRequired.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_requiredDouble_greaterThan_isCorrect() throws {
        let json = #"{"field_1":5.1}"#

        expect(try self.decode(DoubleRequired.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.0.")))
    }
    
    func test_decode_optionalDouble_lessThan_isCorrect() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_optionalDouble_equalTo_isCorrect() throws {
        let json = #"{"field_1":5}"#

        let decoded = try decode(DoubleNotRequired.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_optionalDouble_greaterThan_isCorrect() throws {
        let json = #"{"field_1":5.1}"#

        expect(try self.decode(DoubleNotRequired.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.0.")))
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
