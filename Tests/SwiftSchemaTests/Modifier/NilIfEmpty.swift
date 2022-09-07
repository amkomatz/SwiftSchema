import XCTest
import Nimble

@testable import SwiftSchema

final class NilIfEmptyTests: SwiftSchemaTest {
    
    // MARK: - String
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @NilIfEmpty
        var field1: String? = nil
    }
    
    func test_decode_optionalString_notEmptyInJson_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_emptyInJson_isCorrect() throws {
        let json = #"{"field_1":""}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == nil
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
    
    struct ArrayNotRequired: KeyCodable {
        @Key("field_1")
        @NilIfEmpty
        var field1: [Int]? = nil
    }
    
    func test_decode_optionalArray_notEmptyInJson_isCorrect() throws {
        let json = #"{"field_1":[1, 2, 3, 4, 5]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == [1, 2, 3, 4, 5]
    }
    
    func test_decode_optionalArray_emptyInJson_isCorrect() throws {
        let json = #"{"field_1":[]}"#

        let decoded = try decode(ArrayNotRequired.self, from: json)
        expect(decoded.field1) == nil
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
