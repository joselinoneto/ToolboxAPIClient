//
// Created by Zé on 07/02/21.
//
import Foundation

public struct Endpoint {
    public var path: String
    public var queryItems: [URLQueryItem] = []

    public init(path: String) {
        self.path = path
    }

    public init(path: String, queryItems: [URLQueryItem]) {
        self.path = path
        self.queryItems = queryItems
    }
}