//
//  LoginTarget.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 03/03/2022.
//

import Foundation
import ToolboxAPIClient

public protocol LoginRequestable {
    func createUser(email: String, password: String) async throws -> LoginDto?
    func login(email: String, password: String) async throws -> LoginDto?
    func me() async throws -> UserDto?
}

public enum LoginTarget {
    case createUser
    case login
    case me
}

extension LoginTarget: TargetType {
    public var queryString: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    public var baseURL: URL {
        return URL(string: "https://zeneto.app/")!
    }
    
    public var path: String {
        switch self {
        case .createUser:
            return "create"
        case .login:
            return "login"
        case .me:
            return "me"
        }
    }
    
    public var method: HttpMethodEnum {
        switch self {
        case .createUser:
            return .post
        case .login:
            return .post
        case .me:
            return .get
        }
    }

    public var headers: [String : String]? {
        // Bad pratice! Basic Unit Testing.
        // Must use Keychain
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "token") {
            return ["Authorization": "Bearer  \(token)"]
        }
        return nil
    }
}
