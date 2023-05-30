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
    var expectation = XCTestExpectation(description: "CREATE AND LOGIN")
    let timeout: TimeInterval = 15.0
    var email: String!
    var password: String!

    static var allTests = [
        ("createUser", testCreateUser)
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        email = "".getRandomEmail()
        password = "".getRandomPassword()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUser() async throws {
        let userWorker = LoginManagerAPI()
        
        // create user
        let user = try await userWorker.createUser(email: email, password: password)
        XCTAssertNotNil(user)
        XCTAssertNotNil(user?.token)
        XCTAssertNil(user?.email)
        XCTAssertNil(user?.password)
        
        // login user
        let login = try await userWorker.login(email: email, password: password)
        XCTAssertNotNil(login)
        XCTAssertNotNil(login?.token)
        XCTAssertNil(login?.email)
        XCTAssertNil(login?.password)
        
        let defaults = UserDefaults.standard
        defaults.set(login?.token, forKey: "token")
        
        // valide email with created user
        let me = try await userWorker.me()
        XCTAssertNotNil(me)
        XCTAssertEqual(email, me?.email)

        defaults.removeObject(forKey: "token")
        defaults.synchronize()
    }

    func testErrorLoginUser() throws {
        let userWorker = LoginManagerAPI()
        expectation = expectation(description: "error login")
        // login user
        Task {
            do {
                _ = try await userWorker.me()
            } catch {
                print(error.localizedDescription)
                let exception = error as? APIErrors
                XCTAssertNotNil(exception)
                XCTAssertEqual(exception, APIErrors.authenticationError)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout)
    }

    func testNotFound() throws {
        let userWorker = LoginManagerAPI()
        expectation = expectation(description: "error login")
        // login user
        Task {
            do {
                _ = try await userWorker.notFound()
            } catch {
                print(error.localizedDescription)
                let exception = error as? APIErrors
                XCTAssertNotNil(exception)
                XCTAssertEqual(exception, APIErrors.notFound)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout)
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
