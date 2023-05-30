//
//  File.swift
//  
//
//  Created by José Neto on 12/03/2023.
//

import Foundation

public enum APIErrors: Error, Equatable {
    public static func == (lhs: APIErrors, rhs: APIErrors) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }

    case notFound
    case invalidResponse
    case authenticationError
    case serverError(error: Codable)
}
