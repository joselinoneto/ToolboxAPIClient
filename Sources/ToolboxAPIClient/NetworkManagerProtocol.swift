//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine

@available(OSX 10.15, *)
public protocol NetworkManagerProtocol: class {
    typealias Headers = [String: Any]

    func get<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
}
