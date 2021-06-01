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
    let expectation = XCTestExpectation(description: "GET STORIES DATA FROM MOCKS")
    let timeout: TimeInterval = 5.0

    static var allTests = [
        ("getStories", testGetStorys),
        ("createStrory", testCreateStory)
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetStorys() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
        let professionWorker = StoryManagerAPI()
        var subscriptions = Set<AnyCancellable>()

        professionWorker.getStorys()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    print("Error API: \(error)")
                    XCTFail()
                case .finished:
                    self?.expectation.fulfill()
                    break
                }
            }, receiveValue: { (value: [StoryDto]?) in
                guard let professions = value else {
                    XCTFail()
                    return
                }
                XCTAssertGreaterThan(professions.count, 0)
            }).store(in: &subscriptions)

        wait(for: [expectation], timeout: timeout)
    }
    
    func testCreateStory() throws {
        let professionWorker = StoryManagerAPI()
        var subscriptions = Set<AnyCancellable>()
        
        let profession = StoryDto(id: nil, title: "iOS Engineer")
        professionWorker
            .createStory(profession)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    print("Error API: \(error)")
                    XCTFail()
                case .finished:
                    self?.expectation.fulfill()
                    break
                }
            }, receiveValue: { (value: StoryDto?) in
                XCTAssertNotNil(value)
            }).store(in: &subscriptions)
        
        wait(for: [expectation], timeout: timeout)
    }
    
//    func testGetUser() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
//        var subscriptions = Set<AnyCancellable>()
//
//        userManager.getUsers()
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    print("Error API: \(error)")
//                    XCTFail()
//                case .finished:
//                    self?.expectation.fulfill()
//                    break
//                }
//            }, receiveValue: { (value: [User]?) in
//                guard let users = value else {
//                    XCTFail()
//                    return
//                }
//                XCTAssertGreaterThan(users.count, 0)
//            }).store(in: &subscriptions)
//
//        wait(for: [expectation], timeout: timeout)
//    }


//    func testGetUserWithLimit() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
//        var subscriptions = Set<AnyCancellable>()
//        let count: Int = 10
//
//        userManager.getUsers(count: count)
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    print("Error API: \(error)")
//                    XCTFail()
//                case .finished:
//                    self?.expectation.fulfill()
//                    break
//                }
//            }, receiveValue: { (value: [User]?) in
//                guard let users = value else {
//                    XCTFail()
//                    return
//                }
//                XCTAssertEqual(users.count, count)
//            }).store(in: &subscriptions)
//
//        wait(for: [expectation], timeout: timeout)
//    }
//
//    func testCreateUser() throws {
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
//        var subscriptions = Set<AnyCancellable>()
//
//        let user = User(id: nil, firstName: "Mackenzie", lastName: "Sebire", email: "msebire0@diigo.com")
//        userManager.createUser(user: user)
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    print("Error API: \(error)")
//                    XCTFail()
//                case .finished:
//                    self?.expectation.fulfill()
//                    break
//                }
//            }, receiveValue: { (value: User?) in
//                XCTAssertNotNil(value)
//            }).store(in: &subscriptions)
//
//        wait(for: [expectation], timeout: timeout)
//    }
//
//    func testUpdateUser() throws {
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
//        var subscriptions = Set<AnyCancellable>()
//
////        let user = User(id: "763A636A-E0D5-4077-AB97-95DB2226B26D",
////                        firstName: "Mackenzie",
////                        lastName: "Sebire",
////                        email: "msebire0@diigo.com")
//
//        let user = User(id: "763A636A-E0D5-4077-AB97-95DB2226B26D",
//                        firstName: "Zé",
//                        lastName: "Pqno",
//                        email: "pqno@ze.com")
//
//        userManager.updateUser(user: user)
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    print("Error API: \(error)")
//                    XCTFail()
//                case .finished:
//                    self?.expectation.fulfill()
//                    break
//                }
//            }, receiveValue: { (value: User?) in
//                XCTAssertNotNil(value)
//            }).store(in: &subscriptions)
//
//        wait(for: [expectation], timeout: timeout)
//    }

//    func test1GetUserById() throws {
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
//        var subscriptions = Set<AnyCancellable>()
//
//        userManager.getUser(id: id)
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    print("Error API: \(error)")
//                    XCTFail()
//                case .finished:
//                    self?.expectation.fulfill()
//                    break
//                }
//            }, receiveValue: { (value: User?) in
//                XCTAssertNotNil(value)
//            }).store(in: &subscriptions)
//
//        wait(for: [expectation], timeout: timeout)
//    }

//    func test5DeleteUserById() throws {
//        let networkManager = NetworkManager()
//        let userManager = UserNetworkManager(networkController: networkManager)
//        var subscriptions = Set<AnyCancellable>()
//
//        userManager.deleteUser(id: "")
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    print("Error API: \(error)")
//                    XCTFail()
//                case .finished:
//                    self?.expectation.fulfill()
//                    break
//                }
//            }, receiveValue: { (value: HTTPURLResponse) in
//                let statusCode: Int = value.statusCode
//                XCTAssertEqual(200, statusCode)
//            }).store(in: &subscriptions)
//
//        wait(for: [expectation], timeout: timeout)
//    }
}
