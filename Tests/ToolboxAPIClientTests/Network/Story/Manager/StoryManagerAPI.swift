//
//  File.swift
//  
//
//  Created by Zé on 21/03/21.
//

import Foundation
import Combine
//
import ToolboxAPIClient

public class StoryManagerAPI: StoryRequestable {
    public func getStorys() -> AnyPublisher<[StoryDto]?, Error> {
        BaseNetworkWorker<[StoryDto]>(target: StoryTarget.getStorys).urlRequest()
    }
    
    public func getStorys(limit: Int) -> AnyPublisher<[StoryDto]?, Error> {
        BaseNetworkWorker<[StoryDto]>(target: StoryTarget.getStorysWith(limit)).urlRequest()
    }
    
    public func getStory(storyId: String) -> AnyPublisher<StoryDto?, Error> {
        BaseNetworkWorker<StoryDto>(target: StoryTarget.getStoryBy(storyId)).urlRequest()
    }
    
    public func createStory(_ model: StoryDto) -> AnyPublisher<StoryDto?, Error> {
        BaseNetworkWorker<StoryDto>(target: StoryTarget.postStory).urlRequest(contentBody: model)
    }
}
