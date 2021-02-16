//
// Created by Zé on 12/02/21.
//
import Foundation
import Combine

@available(OSX 10.15, *)
extension NetworkManagerProtocol {
    internal func urlRequest<T: Decodable>(type: T.Type?, httpverb: String, httpBody: Data?, url: URL, headers: Headers) -> AnyPublisher<T?, Error> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpverb
        urlRequest.httpBody = httpBody

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T?.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    internal func urlRequestNoMap(httpverb: String, httpBody: Data?, url: URL, headers: Headers) -> AnyPublisher<HTTPURLResponse, Error> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpverb
        urlRequest.httpBody = httpBody

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
