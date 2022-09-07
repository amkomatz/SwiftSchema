import XCTest
import Nimble

@testable import SwiftSchema

final class BlacklistTests: SwiftSchemaTest {
    
    // MARK: - String
    
    struct StringRequired: KeyCodable {
        @Key("field_1")
        @Blacklist(.decimalDigits)
        var field1: String = ""
    }
    
    struct StringNotRequired: KeyCodable {
        @Key("field_1")
        @Blacklist(.decimalDigits)
        var field1: String? = nil
    }
    
    func test_decode_requiredString_onlyLettersInJson_isCorrect() throws {
        let json = #"{"field_1":"azAZ"}"#

        let decoded = try decode(StringRequired.self, from: json)
        expect(decoded.field1) == "azAZ"
    }
    
    func test_decode_requiredString_lettersAndNumbers_throws() throws {
        let json = #"{"field_1":"azAZ1"}"#

        expect(try self.decode(StringRequired.self, from: json)).to(throwError(ValidationError(message: "has invalid characters.")))
    }
    
    func test_decode_optionalString_onlyLettersInJson_isCorrect() throws {
        let json = #"{"field_1":"azAZ"}"#

        let decoded = try decode(StringNotRequired.self, from: json)
        expect(decoded.field1) == "azAZ"
    }
    
    func test_decode_optionalString_lettersAndNumbers_throws() throws {
        let json = #"{"field_1":"azAZ1"}"#

        expect(try self.decode(StringNotRequired.self, from: json)).to(throwError(ValidationError(message: "has invalid characters.")))
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
