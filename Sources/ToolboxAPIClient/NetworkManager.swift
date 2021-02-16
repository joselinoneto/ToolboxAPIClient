//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine

@available(OSX 10.15, *)
public final class NetworkManager: NetworkManagerProtocol {
    public init() {
    }

    public func get<T: Decodable>(type: T.Type, endPoint: Endpoint) -> AnyPublisher<T?, Error> {
        urlRequest(type: T.self, httpverb: endPoint.method.rawValue, httpBody: nil, url: endPoint.url, headers: endPoint.headers)
    }
    
    public func post<T>(type: T.Type, body: T, endPoint: Endpoint) -> AnyPublisher<T?, Error> where T: Codable {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let data = try? jsonEncoder.encode(body)
        return urlRequest(type: T.self, httpverb: endPoint.method.rawValue, httpBody: data, url: endPoint.url, headers: endPoint.headers)
    }

    public func put<T>(type: T.Type, body: T, endPoint: Endpoint) -> AnyPublisher<T?, Error> where T: Codable {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let data = try? jsonEncoder.encode(body)
        return urlRequest(type: T.self, httpverb: endPoint.method.rawValue, httpBody: data, url: endPoint.url, headers: endPoint.headers)
    }

    public func delete(endpoint: Endpoint) -> AnyPublisher<HTTPURLResponse, Error> {
        urlRequestNoMap(httpverb: endpoint.method.rawValue, httpBody: nil, url: endpoint.url, headers: endpoint.headers)
    }

    public func patch<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T: Decodable {
        Empty(completeImmediately: true).eraseToAnyPublisher()
    }
}
