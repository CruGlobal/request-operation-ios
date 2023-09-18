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
    
    public func sendUrlRequestPublisher(urlRequest: URLRequest) -> AnyPublisher<UrlRequestResponse, UrlRequestResponseError> {
        
        return dataTaskPublisher(for: urlRequest)
            .mapError { (urlError: URLError) in
                                
                return .urlError(urlError: urlError)
            }
            .flatMap({ (object: (data: Data, response: URLResponse)) -> AnyPublisher<UrlRequestResponse, UrlRequestResponseError> in
                
                let urlRequestResponse = UrlRequestResponse(data: object.data, urlResponse: object.response)
                
                guard urlRequestResponse.urlResponse.isSuccessHttpStatusCode else {
                    
                    return Fail(error: .httpStatusCodeError(urlRequestResponse: urlRequestResponse))
                        .eraseToAnyPublisher()
                }
                
                return Just(urlRequestResponse).setFailureType(to: UrlRequestResponseError.self)
                    .eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
    
    public func sendAndDecodeUrlRequestPublisher<T: Codable>(urlRequest: URLRequest) -> AnyPublisher<T, UrlRequestResponseError> {
        
        return sendUrlRequestPublisher(urlRequest: urlRequest)
            .map {
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { (error: Error) in
                return .decodeError(error: error)
            }
            .eraseToAnyPublisher()
    }
}
