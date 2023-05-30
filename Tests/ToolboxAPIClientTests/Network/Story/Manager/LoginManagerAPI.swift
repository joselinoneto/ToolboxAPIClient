//
//  LoginManagerAPI.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 03/03/2022.
//

import Foundation
import ToolboxAPIClient

public class LoginManagerAPI: LoginRequestable {
    public func notFound() async throws {
        _ = try await BaseNetworkWorker<UserDto, APIReason>(target: LoginTarget.notFound).urlRequest()
    }

    public func login(email: String, password: String) async throws -> LoginDto? {
        let login: LoginDto = LoginDto(email: email, password: password, token: nil)
        return try await BaseNetworkWorker<LoginDto, APIReason>(target: LoginTarget.login).urlRequest(contentBody: login)
    }
    
    public func createUser(email: String, password: String) async throws -> LoginDto? {
        let login: LoginDto = LoginDto(email: email, password: password, token: nil)
        return try await BaseNetworkWorker<LoginDto, APIReason>(target: LoginTarget.createUser).urlRequest(contentBody: login)
    }
    
    public func me() async throws -> UserDto? {
        try await BaseNetworkWorker<UserDto, APIReason>(target: LoginTarget.me).urlRequest()
    }
}
