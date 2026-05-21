//
//  RequestBuilderParameters.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/6/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public final class RequestBuilderParameters: Sendable {
    
    public let requestCachePolicy: NSURLRequest.CachePolicy
    public let timeoutIntervalForRequest: TimeInterval
    public let urlString: String
    public let method: RequestMethod
    public let headers: [String: String]?
    public let httpBody: Data?
    public let queryItems: [URLQueryItem]?
    
    public convenience init(urlSession: URLSession, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval? = nil) throws {
        
        try self.init(
            requestCachePolicy: urlSession.configuration.requestCachePolicy,
            timeoutIntervalForRequest: timeoutIntervalForRequest ?? urlSession.configuration.timeoutIntervalForRequest,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems
        )
    }
    
    public convenience init(configuration: URLSessionConfiguration, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?, timeoutIntervalForRequest: TimeInterval? = nil) throws {
        
        try self.init(
            requestCachePolicy: configuration.requestCachePolicy,
            timeoutIntervalForRequest: timeoutIntervalForRequest ?? configuration.timeoutIntervalForRequest,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems
        )
    }
    
    public init(requestCachePolicy: NSURLRequest.CachePolicy, timeoutIntervalForRequest: TimeInterval, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?) throws {
        
        self.requestCachePolicy = requestCachePolicy
        self.timeoutIntervalForRequest = timeoutIntervalForRequest
        self.urlString = urlString
        self.method = method
        self.headers = headers
        self.httpBody = try Self.getHttpBodyData(httpBody: httpBody)
        self.queryItems = queryItems
    }
    
    private static func getHttpBodyData(httpBody: [String: Any]?) throws -> Data? {
        
        guard let httpBody = httpBody, !httpBody.isEmpty else {
            return nil
        }
        
        return try JSONSerialization.data(withJSONObject: httpBody, options: [])
    }
    
    public func getHttpBodyObject(options: JSONSerialization.ReadingOptions = []) throws -> [String: Any] {
        
        guard let httpBody = self.httpBody else {
            return Dictionary()
        }
        
        return try JSONSerialization.jsonObject(with: httpBody, options: options) as? [String: Any] ?? Dictionary()
    }
}
