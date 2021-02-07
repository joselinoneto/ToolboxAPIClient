//
// Created by Zé on 07/02/21.
//
import Foundation
import Combine

@available(OSX 10.15, *)
public final class NetworkManager: NetworkManagerProtocol {

    public init() {
    }
    
    public func get<T: Decodable>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> {
        var urlRequest = URLRequest(url: url)

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
