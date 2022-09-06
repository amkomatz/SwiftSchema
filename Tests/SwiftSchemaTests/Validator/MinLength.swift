import XCTest
import Nimble

@testable import SwiftSchema

final class MinLengthTests: SwiftSchemaTest {
    
    // MARK: - String
    
    struct StringRequired: KeyCodable {
        @Key("field_1")
        @MinLength(5)
        var field1: String = ""
    }
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @MinLength(5)
        var field1: String? = nil
    }
    
    func test_decode_requiredString_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaaa"
    }
    
    func test_decode_requiredString_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_requiredString_lessThanMinLength_throwsCorrect() throws {
        let json = #"{"field_1":"aaaa"}"#

        expect(try self.decode(StringRequired.self, from: json)).to(throwError(ValidationError(message: "must contain at least 5 elements.")))
    }
    
    func test_decode_optionalString_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaaa"
    }
    
    func test_decode_optionalString_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_lessThanMinLength_throwsCorrect() throws {
        let json = #"{"field_1":"aaaa"}"#

        expect(try self.decode(StringNotRequired.self, from: json)).to(throwError(ValidationError(message: "must contain at least 5 elements.")))
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
        @MinLength(5)
        var field1: [Int] = []
    }
    
    struct ArrayNotRequired: KeyCodable {
        @Key("field_1")
        @MinLength(5)
        var field1: [Int]? = []
    }
    
    func test_decode_requiredArray_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5, 6]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5, 6]
    }
    
    func test_decode_requiredArray_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_requiredArray_lessThanMinLength_throwsCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4]}"#

        expect(try self.decode(ArrayRequired.self, from: json)).to(throwError(ValidationError(message: "must contain at least 5 elements.")))
    }
    
    func test_decode_optionalArray_greaterThanMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5, 6]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5, 6]
    }
    
    func test_decode_optionalArray_equalToMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_optionalArray_lessThanMinLength_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4]}"#

        expect(try self.decode(ArrayNotRequired.self, from: json)).to(throwError(ValidationError(message: "must contain at least 5 elements.")))
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
