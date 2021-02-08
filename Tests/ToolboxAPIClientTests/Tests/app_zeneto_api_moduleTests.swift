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
    let expectation = XCTestExpectation(description: "GET USER DATA FROM MOCKY.IO")
    let timeout: TimeInterval = 5.0

    static var allTests = [
        ("getUsers", testGetUser),
        ("getUsersWithLimit", testGetUserWithLimit),
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetUser() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let networkManager = NetworkManager()
        let userManager = UserNetworkManager(networkController: networkManager)
        var subscriptions = Set<AnyCancellable>()

        userManager.getUsers()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    print("Error API: \(error)")
                    XCTFail()
                case .finished:
                    self?.expectation.fulfill()
                    break
                }
            }, receiveValue: { (value: Users?) in
                guard let users = value?.data else {
                    XCTFail()
                    return
                }
                XCTAssertGreaterThan(users.count, 0)
            }).store(in: &subscriptions)

        wait(for: [expectation], timeout: timeout)
    }


    func testGetUserWithLimit() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let networkManager = NetworkManager()
        let userManager = UserNetworkManager(networkController: networkManager)
        var subscriptions = Set<AnyCancellable>()
        let count: Int = 1000

        userManager.getUsers(count: count)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    print("Error API: \(error)")
                    XCTFail()
                case .finished:
                    self?.expectation.fulfill()
                    break
                }
            }, receiveValue: { (value: Users?) in
                guard let users = value?.data else {
                    XCTFail()
                    return
                }
                XCTAssertEqual(users.count, count)
            }).store(in: &subscriptions)

        wait(for: [expectation], timeout: timeout)
    }

    func testCreateUser() throws {
        let networkManager = NetworkManager()
        let userManager = UserNetworkManager(networkController: networkManager)
        var subscriptions = Set<AnyCancellable>()
        
        let user = User(id: "a94bff9b-d0fc-49ba-9a4f-4f9234d16561",
                        firstName: "Mackenzie",
                        lastName: "Sebire",
                        email: "msebire0@diigo.com")

        userManager.createUser(user: user)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    print("Error API: \(error)")
                    XCTFail()
                case .finished:
                    self?.expectation.fulfill()
                    break
                }
            }, receiveValue: { (value: User?) in
                XCTAssertNotNil(value)
            }).store(in: &subscriptions)

        wait(for: [expectation], timeout: timeout)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
