import XCTest
import Nimble

@testable import SwiftSchema

final class NotEmptyTests: SwiftSchemaTest {
    
    // MARK: - String
    
    struct StringRequired: KeyCodable {
        @Key("field_1")
        @NotEmpty
        var field1: String = ""
    }
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @NotEmpty
        var field1: String? = nil
    }
    
    func test_decode_requiredString_notEmptyInJson_isCorrect() throws {
        let json = #"{"field_1":"Hello"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "Hello"
    }
    
    func test_decode_requiredString_emptyInJson_throws() throws {
        let json = #"{"field_1":""}"#

        expect(try self.decode(StringRequired.self, from: json)).to(throwError(ValidationError(message: "must not be empty.")))
    }
    
    func test_decode_optionalString_notEmptyInJson_isCorrect() throws {
        let json = #"{"field_1":"Hello"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "Hello"
    }
    
    func test_decode_optionalString_emptyInJson_throws() throws {
        let json = #"{"field_1":""}"#

        expect(try self.decode(StringNotRequired.self, from: json)).to(throwError(ValidationError(message: "must not be empty.")))
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
        @NotEmpty
        var field1: [Int] = []
    }
    
    struct ArrayNotRequired: KeyCodable {
        @Key("field_1")
        @NotEmpty
        var field1: [Int]? = []
    }
    
    func test_decode_requiredArray_notEmptyInJson_isCorrect() throws {
        let json = #"{"field_1":[1]}"#

        let decoded = try decode(ArrayRequired.self, from: json)
        expect(decoded.field1) == [1]
    }
    
    func test_decode_requiredArray_emptyInJson_throws() throws {
        let json = #"{"field_1":[]}"#

        expect(try self.decode(ArrayRequired.self, from: json)).to(throwError(ValidationError(message: "must not be empty.")))
    }
    
    func test_decode_optionalArray_notEmptyInJson_isCorrect() throws {
        let json = #"{"field_1":[1]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1]
    }
    
    func test_decode_optionalArray_emptyInJson_throws() throws {
        let json = #"{"field_1":[]}"#

        expect(try self.decode(ArrayNotRequired.self, from: json)).to(throwError(ValidationError(message: "must not be empty.")))
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
