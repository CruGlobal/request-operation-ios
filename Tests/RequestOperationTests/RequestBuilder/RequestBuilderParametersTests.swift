//
//  RequestBuilderParametersTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class RequestBuilderParametersTests: XCTestCase {
    
    func testInitWithURLSession() {
        
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
        
        let parameters = RequestBuilderParameters(
            urlSession: session,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: nil
        )
        
        XCTAssertTrue(parameters.requestCachePolicy == requestCachePolicy)
        XCTAssertTrue(parameters.timeoutIntervalForRequest == timeoutIntervalSeconds)
        XCTAssertTrue(parameters.urlString == urlString)
        XCTAssertTrue(parameters.method == method)
        XCTAssertTrue(parameters.headers == headers)
        XCTAssertTrue(parameters.httpBody?.count == 1)
        XCTAssertTrue(parameters.httpBody?["param_1"] as? Int == 1)
        XCTAssertTrue(parameters.queryItems == queryItems)
    }
    
    func testInitWithURLSessionUsesProvidedTimeoutIntervalForRequest() {
        
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
        
        let parameters = RequestBuilderParameters(
            urlSession: session,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: providedTimeoutIntervalSeconds
        )
        
        XCTAssertTrue(parameters.requestCachePolicy == requestCachePolicy)
        XCTAssertTrue(parameters.timeoutIntervalForRequest == providedTimeoutIntervalSeconds)
        XCTAssertTrue(parameters.urlString == urlString)
        XCTAssertTrue(parameters.method == method)
        XCTAssertTrue(parameters.headers == headers)
        XCTAssertTrue(parameters.httpBody?.count == 1)
        XCTAssertTrue(parameters.httpBody?["param_1"] as? Int == 1)
        XCTAssertTrue(parameters.queryItems == queryItems)
    }
    
    func testInitWithURLSessionConfiguration() {
        
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
                
        let parameters = RequestBuilderParameters(
            configuration: configuration,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: nil
        )
        
        XCTAssertTrue(parameters.requestCachePolicy == requestCachePolicy)
        XCTAssertTrue(parameters.timeoutIntervalForRequest == timeoutIntervalSeconds)
        XCTAssertTrue(parameters.urlString == urlString)
        XCTAssertTrue(parameters.method == method)
        XCTAssertTrue(parameters.headers == headers)
        XCTAssertTrue(parameters.httpBody?.count == 1)
        XCTAssertTrue(parameters.httpBody?["param_1"] as? Int == 1)
        XCTAssertTrue(parameters.queryItems == queryItems)
    }
    
    func testInitWithURLSessionConfigurationUsesProvidedTimeoutIntervalForRequest() {
        
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
        
        let parameters = RequestBuilderParameters(
            configuration: configuration,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: providedTimeoutIntervalSeconds
        )
        
        XCTAssertTrue(parameters.requestCachePolicy == requestCachePolicy)
        XCTAssertTrue(parameters.timeoutIntervalForRequest == providedTimeoutIntervalSeconds)
        XCTAssertTrue(parameters.urlString == urlString)
        XCTAssertTrue(parameters.method == method)
        XCTAssertTrue(parameters.headers == headers)
        XCTAssertTrue(parameters.httpBody?.count == 1)
        XCTAssertTrue(parameters.httpBody?["param_1"] as? Int == 1)
        XCTAssertTrue(parameters.queryItems == queryItems)
    }
}
