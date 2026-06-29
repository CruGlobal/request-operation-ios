//
//  CreateIgnoreCacheSessionConfig.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/30/25.
//

import Foundation

public final class CreateIgnoreCacheSessionConfig: CreateUrlSessionConfigInterface {
    
    public static let defaultTimeoutIntervalForRequest: TimeInterval = 60
    
    public init() {
        
    }
    
    public func createConfig(
        timeoutIntervalForRequest: TimeInterval = CreateIgnoreCacheSessionConfig.defaultTimeoutIntervalForRequest
    ) -> URLSessionConfiguration {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        
        return configuration
    }
}
