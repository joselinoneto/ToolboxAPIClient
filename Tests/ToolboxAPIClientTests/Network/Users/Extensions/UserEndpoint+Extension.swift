//
// Created by Zé on 07/02/21.
//
import Foundation
import ToolboxAPIClient

extension Endpoint {
    
    static var users: Self {
        Endpoint(path: "/users")
    }

    static func users(count: Int) -> Self {
        Endpoint(path: "/users", queryItems: [URLQueryItem(name: "limit", value: "\(count)")])
    }

    static func user(id: String) -> Self {
        Endpoint(path: "/users/\(id)")
    }
    
    static func createUser(user: User) -> Self {
        Endpoint(path: "/users", method: .post)
    }
    
    static func deleteUser(id: String) -> Self {
        Endpoint(path: "/users/\(id)", method: .delete)
    }

    static func updateUser(user: User) -> Self {
        Endpoint(path: "/users/\(user.id ?? "")", method: .put)
    }
}
