//
//  File.swift
//  
//
//  Created by Zé on 20/03/21.
//

import Foundation
import Combine
import ToolboxAPIClient

public protocol StoryRequestable {
    func getStorys() -> AnyPublisher<[StoryDto]?, Error>
    func getStorys(limit: Int) -> AnyPublisher<[StoryDto]?, Error>
    func getStory(storyId: String) -> AnyPublisher<StoryDto?, Error>
    func createStory(_ model: StoryDto) -> AnyPublisher<StoryDto?, Error>
}

public enum StoryTarget {
    case getStorys
    case getStorysWith(_ limt: Int)
    case getStoryBy(_ professionId: String)
    case postStory
}

extension StoryTarget: TargetType {
    public var queryString: [URLQueryItem] {
        switch self {
        case .getStorysWith(let limit):
            return [URLQueryItem(name: "limit", value: "\(limit)")]
        default:
            return []
        }
    }
    
    public var baseURL: URL {
        URL(string: "https://astronomia-api.herokuapp.com/")!
    }
    
    public var path: String {
        switch self {
        case .getStorys,
             .getStorysWith:
            return "stories"
        case .postStory:
            return "stories"
        case .getStoryBy(let storyid):
            return "stories/\(storyid)"
        }
    }
    
    public var method: HttpMethodEnum {
        switch self {
        case .getStorys, .getStoryBy, .getStorysWith:
            return .get
        case .postStory:
            return .post
        }
    }
    
    public var headers: [String : String]? {
        ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiIxMTY3MDNFOS1CRjdFLTQyMEEtQjhFRi1BMjY1MTI5NzlEMjEiLCJzdWIiOiJhc3Ryb25vbWlhX2FwaSIsImV4cCI6NjQwOTIyMTEyMDAsImFkbWluIjp0cnVlfQ.D-ZoYLLVfdGaXrIfVl5BlKslN2oFezBpa0PguKCXmhs"]
    }
}
