import XCTest
import Nimble

@testable import SwiftSchema

final class IntToStringTests: SwiftSchemaTest {
    func test_intToString_succeeds() throws {
        struct Req: KeyCodable {
            @Key("field_1")
            @IntToString
            var field1: String = ""
        }

        let json = #"{"field_1":1}"#

        let decoded = try decode(Req.self, from: json)
        expect(decoded.field1) == "1"

        let encoded = try encode(decoded)
        expect(encoded) == json
    }
}
