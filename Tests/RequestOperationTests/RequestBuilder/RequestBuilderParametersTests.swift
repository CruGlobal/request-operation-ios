//
//  RequestBuilderParametersTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Testing
@testable import RequestOperation
import Foundation

struct RequestBuilderParametersTests {
    
    @Test func initWithURLSession() throws {
            
        let requestCachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData
        let timeoutIntervalSeconds: TimeInterval = 30
        let urlString: String = "url-string"
        let method: RequestMethod = .delete
        let headers: [String: String]? = ["param_1": "value_1"]
        let httpBody: [String: Any]? = ["param_1": 1]
        let queryItems: [URLQueryItem]? = nil
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = timeoutIntervalSeconds
        
        let session = URLSession(configuration: configuration)
        
        let parameters = try RequestBuilderParameters(
            urlSession: session,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: nil
        )
        
        let httpBodyObject: [String: Any] = try parameters.getHttpBodyObject()
        
        #expect(parameters.requestCachePolicy == requestCachePolicy)
        #expect(parameters.timeoutIntervalForRequest == timeoutIntervalSeconds)
        #expect(parameters.urlString == urlString)
        #expect(parameters.method == method)
        #expect(parameters.headers == headers)
        #expect(httpBodyObject.count == 1)
        #expect(httpBodyObject["param_1"] as? Int == 1)
        #expect(parameters.queryItems == queryItems)
    }
    
    @Test func initWithURLSessionUsesProvidedTimeoutIntervalForRequest() throws {
            
        let requestCachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData
        let urlString: String = "url-string"
        let method: RequestMethod = .delete
        let headers: [String: String]? = ["param_1": "value_1"]
        let httpBody: [String: Any]? = ["param_1": 1]
        let queryItems: [URLQueryItem]? = nil
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = 60
        
        let session = URLSession(configuration: configuration)
        
        let providedTimeoutIntervalSeconds: TimeInterval = 30
        
        let parameters = try RequestBuilderParameters(
            urlSession: session,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: providedTimeoutIntervalSeconds
        )
        
        let httpBodyObject: [String: Any] = try parameters.getHttpBodyObject()
        
        #expect(parameters.requestCachePolicy == requestCachePolicy)
        #expect(parameters.timeoutIntervalForRequest == providedTimeoutIntervalSeconds)
        #expect(parameters.urlString == urlString)
        #expect(parameters.method == method)
        #expect(parameters.headers == headers)
        #expect(httpBodyObject.count == 1)
        #expect(httpBodyObject["param_1"] as? Int == 1)
        #expect(parameters.queryItems == queryItems)
    }
        
    @Test func initWithURLSessionConfiguration() throws {
            
        let requestCachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData
        let timeoutIntervalSeconds: TimeInterval = 30
        let urlString: String = "url-string"
        let method: RequestMethod = .delete
        let headers: [String: String]? = ["param_1": "value_1"]
        let httpBody: [String: Any]? = ["param_1": 1]
        let queryItems: [URLQueryItem]? = nil
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = timeoutIntervalSeconds
                
        let parameters = try RequestBuilderParameters(
            configuration: configuration,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: nil
        )
        
        let httpBodyObject: [String: Any] = try parameters.getHttpBodyObject()
        
        #expect(parameters.requestCachePolicy == requestCachePolicy)
        #expect(parameters.timeoutIntervalForRequest == timeoutIntervalSeconds)
        #expect(parameters.urlString == urlString)
        #expect(parameters.method == method)
        #expect(parameters.headers == headers)
        #expect(httpBodyObject.count == 1)
        #expect(httpBodyObject["param_1"] as? Int == 1)
        #expect(parameters.queryItems == queryItems)
    }
        
    @Test func initWithURLSessionConfigurationUsesProvidedTimeoutIntervalForRequest() throws {
            
        let requestCachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData
        let urlString: String = "url-string"
        let method: RequestMethod = .delete
        let headers: [String: String]? = ["param_1": "value_1"]
        let httpBody: [String: Any]? = ["param_1": 1]
        let queryItems: [URLQueryItem]? = nil
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = 60
        
        let providedTimeoutIntervalSeconds: TimeInterval = 30
        
        let parameters = try RequestBuilderParameters(
            configuration: configuration,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: providedTimeoutIntervalSeconds
        )
        
        let httpBodyObject: [String: Any] = try parameters.getHttpBodyObject()
                
        #expect(parameters.requestCachePolicy == requestCachePolicy)
        #expect(parameters.timeoutIntervalForRequest == providedTimeoutIntervalSeconds)
        #expect(parameters.urlString == urlString)
        #expect(parameters.method == method)
        #expect(parameters.headers == headers)
        #expect(httpBodyObject.count == 1)
        #expect(httpBodyObject["param_1"] as? Int == 1)
        #expect(parameters.queryItems == queryItems)
    }
}
