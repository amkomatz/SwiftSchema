import XCTest
import Nimble

@testable import SwiftSchema

final class MaxLengthTests: SwiftSchemaTest {
    
    // MARK: - String
    
    struct StringRequired: KeyCodable {
        @Key("field_1")
        @MaxLength(5)
        var field1: String = ""
    }
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @MaxLength(5)
        var field1: String? = nil
    }
    
    func test_decode_requiredString_lessThanMaxLength_isCorrect() throws {
        let json = #"{"field_1":"aaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaa"
    }
    
    func test_decode_requiredString_equalToMaxLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_requiredString_greaterThanMaxLength_throwsCorrect() throws {
        let json = #"{"field_1":"aaaaaa"}"#

        expect(try self.decode(StringRequired.self, from: json)).to(throwError(ValidationError(message: "must contain less than 5 elements.")))
    }
    
    func test_decode_optionalString_lessThanMaxLength_isCorrect() throws {
        let json = #"{"field_1":"aaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaa"
    }
    
    func test_decode_optionalString_equalToMaxLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_greaterThanMaxLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaaa"}"#

        expect(try self.decode(StringNotRequired.self, from: json)).to(throwError(ValidationError(message: "must contain less than 5 elements.")))
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
        @MaxLength(5)
        var field1: [Int] = []
    }
    
    struct ArrayNotRequired: KeyCodable {
        @Key("field_1")
        @MaxLength(5)
        var field1: [Int]? = []
    }
    
    func test_decode_requiredArray_lessThanMaxLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4]
    }
    
    func test_decode_requiredArray_equalToMaxLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_requiredArray_greaterThanMaxLength_throwsCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5, 6]}"#

        expect(try self.decode(ArrayRequired.self, from: json)).to(throwError(ValidationError(message: "must contain less than 5 elements.")))
    }
    
    func test_decode_optionalArray_lessThanMaxLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4]
    }
    
    func test_decode_optionalArray_equalToMaxLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_optionalArray_greaterThanMaxLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5, 6]}"#

        expect(try self.decode(ArrayNotRequired.self, from: json)).to(throwError(ValidationError(message: "must contain less than 5 elements.")))
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
