//
//  GetLanguageEndpoint.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 8/6/24.
//

import Foundation
import RequestOperation
import Combine

class GetLanguageEndpoint: ApiEndpoint {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession, resourceUrl: ApiResourceUrl, context: RequestApiSharedContext) {
        
        self.urlSession = urlSession
        
        super.init(resourceUrl: resourceUrl, requestController: context.requestController)
    }
    
    func getLanguage(id: String) -> AnyPublisher<LanguageModel?, Never> {
        
        return requestController.buildAndSendRequestPublisher(
            urlSession: urlSession,
            urlString: resourceUrl.absoluteUrl + "/" + id,
            method: .get,
            headers: MobileContentApiHeaders.nonAuthorizedHeaders().getHeadersValue(),
            httpBody: nil,
            queryItems: nil
        )
        .map { (response: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>) in
            return response.successCodable?.dataObject
        }
        .catch { _ in
            return Just(nil)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
