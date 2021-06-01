//
//  File.swift
//  
//
//  Created by Zé on 20/03/21.
//

import Foundation
import Combine

@available(OSX 10.15, *)
public class BaseNetworkWorker<T> where T: Codable {
    private var targetType: TargetType
    
    public init(target: TargetType) {
        self.targetType = target
    }
    
    private var finalUrl: URL {
        get {
            //            var components = URLComponents()
            //            components.scheme = "http"
            //            components.host = "localhost"
            //            components.port = 8080
            //            components.path = "/professions"
            ////            //components.queryItems = targetType.queryString
            //            guard let url = components.url else {
            //                preconditionFailure("Invalid URL components: \(components)")
            //            }
            //            return url
            let url = targetType.baseURL.appendingPathComponent(targetType.path)
            return url
        }
    }
    
    private var method: String {
        get {
            targetType.method.rawValue
        }
    }
    
    private var fixedHeaders: [String: String] {
        ["Content-Type": "application/json",
         "cache-control": "no-cache"]
    }
    
    private var headers: [String: String] {
        get {
            guard var headers = targetType.headers else { return fixedHeaders }
            for item in fixedHeaders {
                headers[item.key] = item.value
            }
            return headers
        }
    }
    
    public func urlRequest(contentBody: T? = nil) -> AnyPublisher<T?, Error> {
        // set route with base and path
        var urlRequest = URLRequest(url: finalUrl)
        
        // set headers
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // http method
        urlRequest.httpMethod = method
        
        // http body
        if let httpBody = contentBody {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let data = try? jsonEncoder.encode(httpBody)
            urlRequest.httpBody = data
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T?.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
