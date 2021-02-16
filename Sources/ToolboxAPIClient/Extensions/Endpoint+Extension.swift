//
// Created by Zé on 07/02/21.
//
import Foundation

extension Endpoint {
    public var url: URL {
//        var components = URLComponents()
//        components.scheme = AppTools.httpScheme
//        components.host = AppTools.httpHost
//        components.port = Int(AppTools.httpPort ?? "") ?? 0
//        components.path = path
//        components.queryItems = queryItems
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    public var headers: [String: Any] {
        ["Content-Type": "application/json", "cache-control": "no-cache"]
    }
}
