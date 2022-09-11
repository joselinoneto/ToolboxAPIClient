//
//  File.swift
//  
//
//  Created by Zé on 20/03/21.
//

import Foundation
import Combine

public class BaseNetworkWorker<T> where T: Codable {
    private var targetType: TargetType
    
    public init(target: TargetType) {
        self.targetType = target
    }
    
    private var finalUrl: URL {
        get {
            var components = URLComponents(url: targetType.baseURL, resolvingAgainstBaseURL: true)
            print(targetType)
            if targetType.queryString.count > 0 {
                components?.queryItems = targetType.queryString
            }
            guard let url = components?.url else {
                preconditionFailure("Invalid URL components")
            }
            let finalUrl: URL = url.appendingPathComponent(targetType.path)
            return finalUrl
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
    
    public func urlRequest(contentBody: T? = nil) async throws -> T? {
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

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        return try decoder.decode(T?.self, from: data)
    }
}
