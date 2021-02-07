//
// Created by Zé on 07/02/21.
//
import Foundation
import ToolboxAPIClient

extension Endpoint {
    static var users: Self {
        Endpoint(path: "/3925cd1d-b769-4673-a625-37eb3845c17b")
    }

    static func users(count: Int) -> Self {
        Endpoint(path: "/741cddcb-57de-4421-aba2-52720e751064", queryItems: [URLQueryItem(name: "limit", value: "\(count)")])
    }

    static func user(id: String) -> Self {
        Endpoint(path: "/users/\(id)")
    }
}
