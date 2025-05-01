//
//  GetLanguagesEndpoint.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 8/6/24.
//

import Foundation
import RequestOperation
import Combine

class GetLanguagesEndpoint: ApiEndpoint {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession, resourceUrl: ApiResourceUrl, context: RequestApiSharedContext) {
        
        self.urlSession = urlSession
        
        super.init(resourceUrl: resourceUrl, requestController: context.requestController)
    }
    
    func getLanguages() -> AnyPublisher<[LanguageModel], Never> {
        
        return requestController.buildAndSendRequestPublisher(
            urlSession: urlSession,
            urlString: resourceUrl.absoluteUrl,
            method: .get,
            headers: MobileContentApiHeaders.nonAuthorizedHeaders().getHeadersValue(),
            httpBody: nil,
            queryItems: nil
        )
        .map { (response: RequestCodableResponse<JsonApiResponseDataArray<LanguageModel>, NoResponseCodable>) in
            response.successCodable?.dataArray ?? []
        }
        .catch { _ in
            return Just([])
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
