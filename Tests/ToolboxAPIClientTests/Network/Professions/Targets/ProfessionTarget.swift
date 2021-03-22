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
        URL(string: "https://mockapivapor.herokuapp.com/")!
    }
    
    public var path: String {
        switch self {
        case .getProfessions,
             .getProfessionsWith,
             .postProfession:
            return "professions"
        case .getProfessionBy(let professionId):
            return "professions/\(professionId)"
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
