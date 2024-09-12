//
//  RequestSender.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

public class RequestSender {
        
    public let session: URLSession
    
    public init(session: URLSession) {
        
        self.session = session
    }
    
    public func sendDataTaskPublisher(urlRequest: URLRequest) -> AnyPublisher<RequestDataResponse, URLError> {
        
        return session.dataTaskPublisher(for: urlRequest)
            .map { (tuple: (data: Data, response: URLResponse)) in
                RequestDataResponse(
                    data: tuple.data,
                    urlResponse: tuple.response
                )
            }
            .eraseToAnyPublisher()
    }
}
