import XCTest
import SwiftImage
@testable import SwiftStepicKit
import class Foundation.Bundle

final class SwiftStepicTests: XCTestCase {
    
    let fixturesPath = URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("Fixtures")
    
    func testEncode() throws {
        let inputPath = fixturesPath.appendingPathComponent("pretty-cat.png").path
        let inputImage = Image<RGB<UInt8>>(contentsOfFile: inputPath)!
        let text = "Hello, Cat!"
        let output = try encode(image: inputImage, text: text)
        let restored = try decode(image: output)
        XCTAssertEqual(text, restored)
    }

    func testDecode() throws {
        let inputPath = fixturesPath.appendingPathComponent("hidden-message.png").path
        let inputImage = Image<RGB<UInt8>>(contentsOfFile: inputPath)!
        let expected = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n"
        let restored = try decode(image: inputImage)
        XCTAssertEqual(restored, expected)
    }
}
