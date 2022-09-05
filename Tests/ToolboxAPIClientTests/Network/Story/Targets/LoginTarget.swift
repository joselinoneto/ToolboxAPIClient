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
    case login(email: String, password: String)
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
        case .login(_, _):
            return "login"
        case .me:
            return "me"
        }
    }
    
    public var method: HttpMethodEnum {
        switch self {
        case .createUser:
            return .post
        case .login(_, _):
            return .post
        case .me:
            return .get
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}
