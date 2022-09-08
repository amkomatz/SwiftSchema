import XCTest
import Nimble

@testable import SwiftSchema

final class TrimTests: SwiftSchemaTest {
    struct StringRequired: KeyCodable {
        @Key("field_1")
        @Trim
        var field1: String = ""
    }
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @Trim
        var field1: String? = nil
    }
    
    func test_decode_requiredString_noExtraWhitespaces_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_requiredString_withExtraWhitespaces_isCorrect() throws {
        let json = #"{"field_1":" \n  aaaaa  \t\n "}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_noExtraWhitespaces_isCorrect() throws {
        let json = #"{"field_1":"aaaaa"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
    }
    
    func test_decode_optionalString_withExtraWhitespaces_isCorrect() throws {
        let json = #"{"field_1":" \n  aaaaa  \t\n "}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "aaaaa"
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
}
