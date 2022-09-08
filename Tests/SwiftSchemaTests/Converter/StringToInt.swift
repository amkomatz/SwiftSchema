import XCTest
import Nimble

@testable import SwiftSchema

final class StringToIntTests: SwiftSchemaTest {
    struct Required: KeyCodable {
        @Key("field_1")
        @StringToInt
        var field1: Int = 0
    }
    
    struct NotRequired: KeyCodable {
        @Key("field_1")
        @StringToInt
        var field1: Int? = nil
    }
    
    func test_decode_required_stringInJson_succeeds() throws {
        let json = #"{"field_1":"1"}"#

        let decoded = try decode(Required.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_required_intInJson_fails() throws {
        let json = #"{"field_1":1}"#

        expect(try self.decode(Required.self, from: json)).to(throwError(
            DecodingError.typeMismatch(
                String.self,
                DecodingError.Context(
                    codingPath: ["field_1"],
                    debugDescription: "Expected to decode String but found a number instead."
                )
            )
        ))
    }
    
    func test_decode_required_nilInJson_fails() throws {
        let json = #"{"field_1":null}"#

        expect(try self.decode(Required.self, from: json)).to(throwError(
            DecodingError.valueNotFound(
                String.self,
                DecodingError.Context(
                    codingPath: ["field_1"],
                    debugDescription: "Expected String but found null value instead."
                )
            )
        ))
    }
    
    func test_decode_required_missingInJson_fails() throws {
        let json = #"{"other_field":1}"#

        expect(try self.decode(Required.self, from: json)).to(throwError(
            DecodingError.keyNotFound(
                "field_1",
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: "No value associated with key field_1 (\"field_1\")."
                )
            )
        ))
    }
    
    func test_decode_optional_intInJson_succeeds() throws {
        let json = #"{"field_1":"1"}"#

        let decoded = try decode(NotRequired.self, from: json)
        expect(decoded.field1) == 1

        let encoded = try encode(decoded)
        expect(encoded) == json
    }
    
    func test_decode_optional_nullInJson_succeeds() throws {
        let json = #"{"field_1":null}"#

        let decoded = try decode(NotRequired.self, from: json)
        expect(decoded.field1) == nil

        let encoded = try encode(decoded)
        expect(encoded) == json
    }
    
    func test_decode_optional_missingInJson_succeeds() throws {
        let json = #"{"other_field":null}"#

        let decoded = try decode(NotRequired.self, from: json)
        expect(decoded.field1) == nil

        let encoded = try encode(decoded)
        expect(encoded) == #"{"field_1":null}"#
    }
    
    func test_encode_required_validIntString_jsonIsCorrect() throws {
        let decoded = Required(field1: 1)

        let encoded = try encode(decoded)
        expect(encoded) == #"{"field_1":"1"}"#
    }
}
