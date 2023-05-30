//
//  File.swift
//  
//
//  Created by José Neto on 12/03/2023.
//

import Foundation

struct APIReason: Codable {
    let error: Bool
    let reason: String
}

class APIError: Codable {
    let errorCode: Int
    let reason: APIReason

    init(errorCode: String, reason: APIReason) {
        self.errorCode = Int(errorCode) ?? 0
        self.reason = reason
    }
}
