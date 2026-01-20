//
//  RequestSender.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

open class RequestSender {
            
    public init() {
        
    }
    
    public func sendDataTask(urlRequest: URLRequest, urlSession: URLSession) async throws -> RequestDataResponse {
        
        let tuple: (data: Data, response: URLResponse) = try await urlSession.data(for: urlRequest)
        
        let response = RequestDataResponse(
            data: tuple.data,
            urlResponse: tuple.response
        )
        
        return response
    }
    
    public func sendDataTaskPublisher(urlRequest: URLRequest, urlSession: URLSession) -> AnyPublisher<RequestDataResponse, Error> {
                
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map { (tuple: (data: Data, response: URLResponse)) in
                RequestDataResponse(
                    data: tuple.data,
                    urlResponse: tuple.response
                )
            }
            .mapError { (urlError: URLError) in
                return urlError.toError()
            }
            .eraseToAnyPublisher()
    }
}
