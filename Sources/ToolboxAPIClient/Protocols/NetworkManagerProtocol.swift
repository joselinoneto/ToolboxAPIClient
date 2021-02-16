//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine

@available(OSX 10.15, *)
public protocol NetworkManagerProtocol: class {
    typealias Headers = [String: Any]

    func get<T>(type: T.Type, endPoint: Endpoint) -> AnyPublisher<T?, Error> where T: Decodable
    func post<T>(type: T.Type, body: T, endPoint: Endpoint) -> AnyPublisher<T?, Error> where T: Codable
    func put<T>(type: T.Type, body: T, endPoint: Endpoint) -> AnyPublisher<T?, Error> where T: Codable
    func delete(endpoint: Endpoint) -> AnyPublisher<HTTPURLResponse, Error>
    func patch<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
}
