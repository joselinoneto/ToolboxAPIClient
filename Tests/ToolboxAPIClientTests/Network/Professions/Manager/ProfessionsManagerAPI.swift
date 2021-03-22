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

public class ProfessionsManagerAPI: ProfessionRequestable {
    public func getProfessions() -> AnyPublisher<[ProfessionDto]?, Error> {
        BaseNetworkWorker<[ProfessionDto]>(target: ProfessionTarget.getProfessions).urlRequest()
    }
    
    public func getProfessions(limit: Int) -> AnyPublisher<[ProfessionDto]?, Error> {
        BaseNetworkWorker<[ProfessionDto]>(target: ProfessionTarget.getProfessionsWith(limit)).urlRequest()
    }
    
    public func getProfession(professionId: String) -> AnyPublisher<ProfessionDto?, Error> {
        BaseNetworkWorker<ProfessionDto>(target: ProfessionTarget.getProfessionBy(professionId)).urlRequest()
    }
    
    public func createProfession(_ model: ProfessionDto) -> AnyPublisher<ProfessionDto?, Error> {
        BaseNetworkWorker<ProfessionDto>(target: ProfessionTarget.postProfession).urlRequest(contentBody: model)
    }
}
