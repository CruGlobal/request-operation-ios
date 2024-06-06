//
//  LanguagesEndpoint.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import RequestOperation
import Combine

class LanguagesEndpoint: ApiEndpoint {
    
    func getLanguages() -> AnyPublisher<[LanguageModel], Never> {
        
        let apiRequest = getEndpointBasedRequest(
            method: .get,
            requestHeaders: MobileContentApiHeaders.nonAuthorizedHeaders()
        )
        
        return requestSender
            .sendAndDecodeDataTaskPublisher(request: apiRequest)
            .map { (response: RequestCodableResponse<JsonApiResponseDataArray<LanguageModel>>) in
                return response.codable?.dataArray ?? []
            }
            .catch { _ in
                return Just([])
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getLanguage(id: String) -> AnyPublisher<LanguageModel?, Never> {
        
        let apiRequest = getEndpointBasedRequest(
            path: path + "/" + id,
            method: .get,
            requestHeaders: MobileContentApiHeaders.nonAuthorizedHeaders()
        )
        
        return requestSender
            .sendAndDecodeDataTaskPublisher(request: apiRequest)
            .map { (response: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>>) in
                return response.codable?.data
            }
            .catch { _ in
                return Just(nil)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
