import XCTest
@testable import ToolboxAPIClient

final class ToolboxAPIClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ToolboxAPIClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
