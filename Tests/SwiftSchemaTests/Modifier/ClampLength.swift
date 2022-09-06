import XCTest
import Nimble

@testable import SwiftSchema

final class ClampLengthTests: SwiftSchemaTest {
    
    // MARK: - String
    
    struct StringRequired: KeyCodable {
        @Key("field_1")
        @ClampLength(5)
        var field1: String = ""
    }
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @ClampLength(5)
        var field1: String? = nil
    }
    
    func test_decode_requiredString_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_requiredString_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_requiredString_lessThanMinLength_throws() throws {
        let json = #"{"field_1":"aaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaa"
    }
    
    func test_decode_optionalString_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_lessThanMinLength_throws() throws {
        let json = #"{"field_1":"aaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaa"
    }
    
    func test_decode_optionalString_nilInJson_isCorrect() throws {
        let json = #"{"field_1":null}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    func test_decode_optionalString_missingInJson_isCorrect() throws {
        let json = #"{"other_field":null}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    // MARK: - Array
    
    struct ArrayRequired: KeyCodable {
        @Key("field_1")
        @ClampLength(5)
        var field1: [Int] = []
    }
    
    struct ArrayNotRequired: KeyCodable {
        @Key("field_1")
        @ClampLength(5)
        var field1: [Int]? = []
    }
    
    func test_decode_requiredArray_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5, 6]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_requiredArray_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_requiredArray_lessThanMinLength_throws() throws {
        let json = #"{"field_1":[1, 2, 3, 4]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4]
    }
    
    func test_decode_optionalArray_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5, 6]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_optionalArray_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_optionalArray_lessThanMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4]
    }
    
    func test_decode_optionalArray_nilInJson_isCorrect() throws {
        let json = #"{"field_1":null}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
    
    func test_decode_optionalArray_missingInJson_isCorrect() throws {
        let json = #"{"other_field":null}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == nil
    }
}
