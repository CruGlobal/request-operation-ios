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
    
    public func sendUrlRequestPublisher(urlRequest: URLRequest) -> AnyPublisher<UrlRequestResponse, URLError> {
        
        return dataTaskPublisher(for: urlRequest)
            .map { (object: (data: Data, response: URLResponse)) in
                
                let urlRequestResponse = UrlRequestResponse(data: object.data, urlResponse: object.response)
                
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
