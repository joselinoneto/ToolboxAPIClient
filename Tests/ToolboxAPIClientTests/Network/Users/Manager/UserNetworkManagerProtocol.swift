//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine
//
import ToolboxAPIClient

protocol UserNetworkManagerProtocol: class {
    var networkController: NetworkManagerProtocol { get }

    func getUsers() -> AnyPublisher<[User]?, Error>
    func getUsers(count: Int) -> AnyPublisher<[User]?, Error>
    func getUser(id: String) -> AnyPublisher<User?, Error>
    func createUser(user: User) -> AnyPublisher<User?, Error>
    func deleteUser(id: String) -> AnyPublisher<HTTPURLResponse, Error>
}
