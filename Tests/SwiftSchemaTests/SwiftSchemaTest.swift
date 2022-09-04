import XCTest

class SwiftSchemaTest: XCTestCase {
    enum TestCaseError: Error {
        case invalidData
    }
    
    func decode<T>(_ type: T.Type, from json: String) throws -> T where T: Decodable {
        guard let data = json.data(using: .utf8) else {
            throw TestCaseError.invalidData
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func encode<T>(_ value: T) throws -> String where T: Encodable {
        let data = try JSONEncoder().encode(value)
        
        guard let json = String(data: data, encoding: .utf8) else {
            throw TestCaseError.invalidData
        }
        
        return json
    }
}
