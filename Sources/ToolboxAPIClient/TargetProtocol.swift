//
//  File.swift
//  
//
//  Created by Zé on 20/03/21.
//

import Foundation

/// The protocol used to define the specifications necessary for a `MoyaProvider`.
public protocol TargetType {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HttpMethodEnum { get }

    /// Provides stub data for use in testing.
    //var sampleData: Data { get }

    /// The type of HTTP task to be performed.
    //var task: Moya.Task { get }

    /// The headers to be used in the request.
    var headers: [String : String]? { get }
    
    var queryString: [URLQueryItem] { get }
}
