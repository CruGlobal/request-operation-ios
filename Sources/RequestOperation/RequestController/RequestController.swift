//
//  RequestController.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

public class RequestController {
    
    public let requestBuilder: RequestBuilder
    public let requestSender: RequestSender
    public let requestRetrier: RequestRetrier?
    
    public init(requestBuilder: RequestBuilder, requestSender: RequestSender, requestRetrier: RequestRetrier? = nil) {
        
        self.requestBuilder = requestBuilder
        self.requestSender = requestSender
        self.requestRetrier = requestRetrier
    }
    
    public func buildAndSendRequestPublisher<T: Codable>(urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval?) -> AnyPublisher<RequestCodableResponse<T>, RequestCodableResponseError> {
        
        return internalBuildAndSendRequestPublisher(
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody, 
            queryItems: queryItems,
            timeoutIntervalForRequest: timeoutIntervalForRequest
        )
        .decodeRequestDataResponse(decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
    private func internalBuildAndSendRequestPublisher(urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval?) -> AnyPublisher<RequestDataResponse, URLError> {
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: requestSender.session,
                urlString: urlString,
                method: method,
                headers: headers,
                httpBody: httpBody,
                queryItems: queryItems,
                timeoutIntervalForRequest: timeoutIntervalForRequest
            )
        )
        
        return requestSender
            .sendDataTaskPublisher(urlRequest: urlRequest)
            .flatMap({ [weak self] (response: RequestDataResponse) -> AnyPublisher<RequestDataResponse, URLError> in
                
                guard let weakSelf = self else {
                    
                    return Just(response)
                        .setFailureType(to: URLError.self)
                        .eraseToAnyPublisher()
                }
                
                let retryPolicy: RetryPolicy
                
                if let requestRetrier = weakSelf.requestRetrier {
                    
                    retryPolicy = requestRetrier.shouldRetryRequest(
                        response: response,
                        httpStatusCode: response.urlResponse.httpStatusCode,
                        isSuccessHttpStatusCode: response.urlResponse.isSuccessHttpStatusCode
                    )
                }
                else {
                    
                    retryPolicy = .doNotRetry
                }
                
                switch retryPolicy {
               
                case .doNotRetry:
                    
                    return Just(response)
                        .setFailureType(to: URLError.self)
                        .eraseToAnyPublisher()
                    
                case .retry( _):
                    
                    return weakSelf.internalBuildAndSendRequestPublisher(
                        urlString: urlString,
                        method: method,
                        headers: headers,
                        httpBody: httpBody,
                        queryItems: queryItems,
                        timeoutIntervalForRequest: timeoutIntervalForRequest
                    )
                    .eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
}
