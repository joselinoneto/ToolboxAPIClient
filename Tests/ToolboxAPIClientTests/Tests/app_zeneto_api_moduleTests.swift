//
//  zeneto_api_moduleTests.swift
//  zeneto-api-moduleTests
//
//  Created by Zé on 07/02/21.
//

import XCTest
//
import Combine

@testable import ToolboxAPIClient
class app_zeneto_api_moduleTests: XCTestCase {
    let expectation = XCTestExpectation(description: "CREATE AND LOGIN")
    let timeout: TimeInterval = 5.0
    let email: String = "".getRandomEmail()
    let password: String = "".getRandomPassword()

    static var allTests = [
        ("createUser", testCreateUser),
        ("loginUser", testLoginUser),
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUser() async throws {
        let userWorker = LoginManagerAPI()
        let user = try await userWorker.createUser(email: email, password: password)
        XCTAssertNotNil(user)
    }
    
    func testLoginUser() async throws {
        let userWorker = LoginManagerAPI()
        let user = try await userWorker.login(email: email, password: password)
        XCTAssertNotNil(user)
    }
}

extension String {
    
    func getRandomEmail(currentStringAsUsername: Bool = false) -> String {
        let providers = ["gmail.com", "hotmail.com", "icloud.com", "live.com"]
        let randomProvider = providers.randomElement()!
        if currentStringAsUsername && self.count > 0 {
            return "\(self)@\(randomProvider)"
        }
        let username = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        return "\(username)@\(randomProvider)"
    }
    
    func getRandomPassword() -> String {
        UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
    }
}
