//
//  ApiRequest.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class ApiRequest: RequestInterface {
    
    public let urlSession: URLSession
    public let baseUrl: RequestBaseUrl
    public let path: String
    public let method: RequestMethod
    public let requestHeaders: ApiRequestHeaders
    public let httpBody: [String: Any]?
    public let queryItems: [URLQueryItem]?
    
    public var headers: [String: String] {
        return requestHeaders.getHeadersValue()
    }
    
    public init(urlSession: URLSession, baseUrl: RequestBaseUrl, path: String, method: RequestMethod, requestHeaders: ApiRequestHeaders, httpBody: [String : Any]?, queryItems: [URLQueryItem]?) {
        
        self.urlSession = urlSession
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.requestHeaders = requestHeaders
        self.httpBody = httpBody
        self.queryItems = queryItems
    }
}
