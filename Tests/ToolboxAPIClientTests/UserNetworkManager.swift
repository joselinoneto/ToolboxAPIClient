//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine
import ToolboxAPIClient

final class UserNetworkManager: UserNetworkManagerProtocol {
    let networkController: NetworkManagerProtocol

    init(networkController: NetworkManagerProtocol) {
        self.networkController = networkController
    }

    func getUsers() -> AnyPublisher<Users, Error> {
        let endpoint = Endpoint.users
        return networkController.get(type: Users.self, url: endpoint.url, headers: endpoint.headers)
    }

    func getUsers(count: Int) -> AnyPublisher<Users, Error> {
        let endpoint = Endpoint.users(count: count)
        return networkController.get(type: Users.self, url: endpoint.url, headers: endpoint.headers)
    }

    func getUser(id: String) -> AnyPublisher<User, Error> {
        let endpoint = Endpoint.user(id: id)
        return networkController.get(type: User.self, url: endpoint.url, headers: endpoint.headers)
    }
}
