//
//  RequestController.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

open class RequestController {
    
    public let requestBuilder: RequestBuilder
    public let requestSender: RequestSender
    public let requestRetrier: RequestRetrier?
    
    public init(requestBuilder: RequestBuilder, requestSender: RequestSender, requestRetrier: RequestRetrier? = nil) {
        
        self.requestBuilder = requestBuilder
        self.requestSender = requestSender
        self.requestRetrier = requestRetrier
    }
    
    open func buildAndSendRequestPublisher<SuccessCodable: Codable, FailureCodable: Codable>(urlSession: URLSession, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval? = nil, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, FailureCodable>, Error> {
        
        return internalBuildAndSendRequestPublisher(
            urlSession: urlSession,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: timeoutIntervalForRequest
        )
        .decodeRequestDataResponseForSuccessOrFailureCodable(decoder: decoder)
        .eraseToAnyPublisher()
    }
    
    private func internalBuildAndSendRequestPublisher(urlSession: URLSession, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval?) -> AnyPublisher<RequestDataResponse, Error> {
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: urlSession,
                urlString: urlString,
                method: method,
                headers: headers,
                httpBody: httpBody,
                queryItems: queryItems,
                timeoutIntervalForRequest: timeoutIntervalForRequest
            )
        )
        
        return requestSender
            .sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .flatMap({ (response: RequestDataResponse) -> AnyPublisher<RequestDataResponse, Error> in
                
                return self.retryRequestIfNeededPublisher(
                    response: response,
                    urlSession: urlSession,
                    urlString: urlString,
                    method: method,
                    headers: headers,
                    httpBody: httpBody,
                    queryItems: queryItems,
                    timeoutIntervalForRequest: timeoutIntervalForRequest
                )
            })
            .eraseToAnyPublisher()
    }
    
    private func retryRequestIfNeededPublisher(response: RequestDataResponse, urlSession: URLSession, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval?) -> AnyPublisher<RequestDataResponse, Error> {
        
        guard let requestRetrier = self.requestRetrier else {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return requestRetrier.shouldRetryRequestPublisher(
            response: response,
            httpStatusCode: response.urlResponse.httpStatusCode,
            isSuccessHttpStatusCode: response.urlResponse.isSuccessHttpStatusCode
        )
        .setFailureType(to: Error.self)
        .flatMap({ [weak self] (retryPolicy: RetryPolicy) -> AnyPublisher<RequestDataResponse, Error> in
                   
            guard let weakSelf = self else {
                
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            
            switch retryPolicy {
           
            case .doNotRetry:
                
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                
            case .retry( _):
                
                return weakSelf.internalBuildAndSendRequestPublisher(
                    urlSession: urlSession,
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
