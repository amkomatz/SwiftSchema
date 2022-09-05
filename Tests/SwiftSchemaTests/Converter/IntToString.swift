import XCTest
import Nimble

@testable import SwiftSchema

final class IntToStringTests: SwiftSchemaTest {
    struct Required: KeyCodable {
        @Key("field_1")
        @IntToString
        var field1: String = ""
    }
    
    struct NotRequired: KeyCodable {
        @Key("field_1")
        @IntToString
        var field1: String? = nil
    }
    
    func test_decode_required_intInJson_succeeds() throws {
        let json = #"{"field_1":1}"#

        let decoded = try decode(Required.self, from: json)
        expect(decoded.field1) == "1"
    }
    
    func test_decode_required_floatInJson_fails() throws {
        let json = #"{"field_1":1.5}"#

        expect(try self.decode(Required.self, from: json)).to(throwError(
            DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: ["field_1"],
                    debugDescription: "Parsed JSON number <1.5> does not fit in Int."
                )
            )
        ))
    }
    
    func test_decode_required_stringInJson_fails() throws {
        let json = #"{"field_1":"1"}"#

        expect(try self.decode(Required.self, from: json)).to(throwError(
            DecodingError.typeMismatch(
                Int.self,
                DecodingError.Context(
                    codingPath: ["field_1"],
                    debugDescription: "Expected to decode Int but found a string/data instead."
                )
            )
        ))
    }
    
    func test_decode_required_nilInJson_fails() throws {
        let json = #"{"field_1":null}"#

        expect(try self.decode(Required.self, from: json)).to(throwError(
            DecodingError.valueNotFound(
                Int.self,
                DecodingError.Context(
                    codingPath: ["field_1"],
                    debugDescription: "Expected Int but found null value instead."
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
        let json = #"{"field_1":1}"#

        let decoded = try decode(NotRequired.self, from: json)
        expect(decoded.field1) == "1"

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
        let decoded = Required(field1: "1")

        let encoded = try encode(decoded)
        expect(encoded) == #"{"field_1":1}"#
    }
    
    func test_encode_required_validFloatString_throws() throws {
        let decoded = Required(field1: "1.5")

        expect(try self.encode(decoded)).to(throwError(IntToString<Int, String>.Exception.invalidIntegerString))
    }
    
    func test_encode_required_nonIntString_throws() throws {
        let decoded = Required(field1: "Hello!")

        expect(try self.encode(decoded)).to(throwError(IntToString<Int, String>.Exception.invalidIntegerString))
    }
}
