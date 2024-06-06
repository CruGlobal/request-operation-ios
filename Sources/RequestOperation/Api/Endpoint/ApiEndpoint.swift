//
//  ApiEndpoint.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class ApiEndpoint {
    
    public let baseUrl: RequestBaseUrl
    public let requestSender: RequestSender
    public let urlSession: URLSession
    public let path: String
    
    public init(path: String, context: ApiEndpointContext) {
        
        self.baseUrl = context.baseUrl
        self.requestSender = context.requestSender
        self.urlSession = context.urlSession
        self.path = path
    }
    
    public func getEndpointBasedRequest(urlSession: URLSession? = nil, path: String? = nil, method: RequestMethod, requestHeaders: ApiRequestHeaders, httpBody: [String : Any]? = nil, queryItems: [URLQueryItem]? = nil) -> ApiRequest {
        
        return ApiRequest(
            urlSession: urlSession ?? self.urlSession,
            baseUrl: baseUrl,
            path: path ?? self.path,
            method: method,
            requestHeaders: requestHeaders,
            httpBody: httpBody,
            queryItems: queryItems
        )
    }
}
