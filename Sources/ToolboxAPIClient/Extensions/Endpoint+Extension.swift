//
// Created by Zé on 07/02/21.
//
import Foundation

extension Endpoint {
    public var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3" + path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    public var headers: [String: Any] {
        ["app-id": "app.zeneto.zeneto-api-module"]
    }
}
