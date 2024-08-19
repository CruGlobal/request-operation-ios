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
    
    func getLanguage(id: String) -> AnyPublisher<LanguageModel?, Never> {
        
        return requestController.buildAndSendRequestPublisher(
            urlString: resourceUrl.absoluteUrl + "/" + id,
            method: .get,
            headers: MobileContentApiHeaders.nonAuthorizedHeaders().getHeadersValue(),
            httpBody: nil,
            queryItems: nil
        )
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
