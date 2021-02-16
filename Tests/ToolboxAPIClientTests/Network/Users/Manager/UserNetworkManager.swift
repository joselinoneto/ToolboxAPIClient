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

    func getUsers() -> AnyPublisher<[User]?, Error> {
        let endpoint = Endpoint.users
        return networkController.get(type: [User].self, endPoint: endpoint)
    }

    func getUsers(count: Int) -> AnyPublisher<[User]?, Error> {
        let endpoint = Endpoint.users(count: count)
        return networkController.get(type: [User].self, endPoint: endpoint)
    }

    func getUser(id: String) -> AnyPublisher<User?, Error> {
        let endpoint = Endpoint.user(id: id)
        return networkController.get(type: User.self, endPoint: endpoint)
    }
    
    func createUser(user: User) -> AnyPublisher<User?, Error> {
        let endpoint = Endpoint.createUser(user: user)
        return networkController.post(type: User.self, body: user, endPoint: endpoint)
    }
    
    func updateUser(user: User) -> AnyPublisher<User?, Error> {
        let endpoint = Endpoint.updateUser(user: user)
        return networkController.put(type: User.self, body: user, endPoint: endpoint)
    }
    
    func deleteUser(id: String) -> AnyPublisher<HTTPURLResponse, Error> {
        let endpoint = Endpoint.deleteUser(id: id)
        return networkController.delete(endpoint: endpoint)
    }
}
