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
    
    func getLanguages() -> AnyPublisher<[LanguageModel], Never> {
        
        return requestController.buildAndSendRequestPublisher(
            urlString: resourceUrl.absoluteUrl,
            method: .get,
            headers: MobileContentApiHeaders.nonAuthorizedHeaders().getHeadersValue(),
            httpBody: nil,
            queryItems: nil
        )
        .map { (response: RequestCodableResponse<JsonApiResponseDataArray<LanguageModel>>) in
            response.codable?.dataArray ?? []
        }
        .catch { _ in
            return Just([])
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
