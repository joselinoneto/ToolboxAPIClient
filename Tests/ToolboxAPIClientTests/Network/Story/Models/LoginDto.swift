//
//  LoginDto.swift
//  
//
//  Created by José Neto on 05/09/2022.
//

import Foundation

public struct LoginDto: Codable {
    public let email: String?
    public let password: String?
    public let token: String?
}
