//
//  ApiEndpoint.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

open class ApiEndpoint {
    
    public let resourceUrl: ApiResourceUrl
    public let requestController: RequestController
    
    public convenience init(resourceUrl: ApiResourceUrl, context: RequestApiSharedContext) {
        
        self.init(
            resourceUrl: resourceUrl,
            requestController: context.requestController
        )
    }
    
    public init(resourceUrl: ApiResourceUrl, requestController: RequestController) {
        
        self.resourceUrl = resourceUrl
        self.requestController = requestController
    }
    
    public func buildAndSendRequestPublisher<T: Codable>(resourceUrl: ApiResourceUrl, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval? = nil) -> AnyPublisher<RequestCodableResponse<T>, RequestCodableResponseError> {
        
        return buildAndSendRequestPublisher(
            urlString: resourceUrl.absoluteUrl,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: timeoutIntervalForRequest
        )
        .eraseToAnyPublisher()
    }
    
    public func buildAndSendRequestPublisher<T: Codable>(urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval? = nil) -> AnyPublisher<RequestCodableResponse<T>, RequestCodableResponseError> {
        
        return requestController.buildAndSendRequestPublisher(
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: timeoutIntervalForRequest
        )
        .eraseToAnyPublisher()
    }
}
