//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine
//
import ToolboxAPIClient

protocol UserNetworkManagerProtocol: class {
    var networkController: NetworkManagerProtocol { get }

    func getUsers() -> AnyPublisher<Users, Error>
    func getUsers(count: Int) -> AnyPublisher<Users, Error>
    func getUser(id: String) -> AnyPublisher<User, Error>
}
