import XCTest
import Nimble

@testable import SwiftSchema

final class SmokeTests: SwiftSchemaTest {
    
    func test_decode_converterAndValidator() throws {
        struct Req: KeyCodable {
            @Key("field_1")
            @StringToInt
            @LessThanOrEqualTo(5)
            var field1: Int = 0
        }
        
        let json = #"{"field_1":"1"}"#
        
        let decoded = try decode(Req.self, from: json)
        expect(decoded.field1) == 1
    }
    
    func test_decode_roundAndLessThanOrEqualTo_roundUpToMax_succeeds() throws {
        struct Req: KeyCodable {
            @Key("field_1")
            @Round
            @LessThanOrEqualTo(5)
            var field1: Double = 0
        }
        
        let json = #"{"field_1":4.5}"#
        
        let decoded = try decode(Req.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_roundAndLessThanOrEqualTo_roundDownToMax_succeeds() throws {
        struct Req: KeyCodable {
            @Key("field_1")
            @Round
            @LessThanOrEqualTo(5)
            var field1: Double = 0
        }
        
        let json = #"{"field_1":5.2}"#
        
        let decoded = try decode(Req.self, from: json)
        expect(decoded.field1) == 5
    }
    
    func test_decode_roundAndLessThanOrEqualTo_roundUpToAboveMax_fails() throws {
        struct Req: KeyCodable {
            @Key("field_1")
            @Round
            @LessThanOrEqualTo(5)
            var field1: Double = 0
        }
        
        let json = #"{"field_1":5.5}"#
        
        expect(try self.decode(Req.self, from: json)).to(throwError(ValidationError(message: "must be less than or equal to 5.0.")))
    }
}
