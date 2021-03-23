//
//  File.swift
//  
//
//  Created by Zé on 20/03/21.
//

import Foundation
import Combine
import ToolboxAPIClient

public protocol ProfessionRequestable {
    func getProfessions() -> AnyPublisher<[ProfessionDto]?, Error>
    func getProfessions(limit: Int) -> AnyPublisher<[ProfessionDto]?, Error>
    func getProfession(professionId: String) -> AnyPublisher<ProfessionDto?, Error>
    func createProfession(_ model: ProfessionDto) -> AnyPublisher<ProfessionDto?, Error>
}

public enum ProfessionTarget {
    case getProfessions
    case getProfessionsWith(_ limt: Int)
    case getProfessionBy(_ professionId: String)
    case postProfession
}

extension ProfessionTarget: TargetType {
    public var queryString: [URLQueryItem] {
        switch self {
        case .getProfessionsWith(let limit):
            return [URLQueryItem(name: "limit", value: "\(limit)")]
        default:
            return []
        }
    }
    
    public var baseURL: URL {
        URL(string: "https://run.mocky.io/v3/")!
    }
    
    public var path: String {
        switch self {
        case .getProfessions,
             .getProfessionsWith:
            return "8ae911b5-f8b5-4b67-a341-e85fbc0e635a"
        case .postProfession:
            return "1131699f-4cfe-4efc-b196-bba55d3e0c01"
        case .getProfessionBy(let professionId):
            return "8ae911b5-f8b5-4b67-a341-e85fbc0e635a/\(professionId)"
        }
    }
    
    public var method: HttpMethodEnum {
        switch self {
        case .getProfessions, .getProfessionBy, .getProfessionsWith:
            return .get
        case .postProfession:
            return .post
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}
