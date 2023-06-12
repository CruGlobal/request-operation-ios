//
//  URLSession+SendUrlRequest.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 6/12/2023.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
    
    public func sendUrlRequestPublisher(urlRequest: URLRequest) -> AnyPublisher<UrlRequestResponse, Error> {
        
        return dataTaskPublisher(for: urlRequest)
            .tryMap {
                
                let data: Data = $0.data
                let urlResponse: URLResponse = $0.response
                
                let urlRequestResponse = UrlRequestResponse(data: data, urlResponse: urlResponse)
                
                guard urlRequestResponse.urlResponse.isSuccessHttpStatusCode else {
                    
                    let errorCode: Int = -1
                    let httpStatusCode: Int = urlRequestResponse.urlResponse.httpStatusCode ?? -1
                    let errorMessage: String = "Send UrlRequest failed. Server responded with http status code: \(httpStatusCode)"
                    
                    throw NSError(domain: "", code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                }
                
                return urlRequestResponse
            }
            .eraseToAnyPublisher()
    }
    
    public func sendAndDecodeUrlRequestPublisher<T: Codable>(urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        
        return sendUrlRequestPublisher(urlRequest: urlRequest)
            .map {
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
