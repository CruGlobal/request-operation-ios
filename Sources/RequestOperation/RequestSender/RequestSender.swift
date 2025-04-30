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
    
    open func sendDataTaskPublisher(urlRequest: URLRequest, urlSession: URLSession) -> AnyPublisher<RequestDataResponse, Error> {
                
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
