//
//  CreateIgnoreCacheSessionConfig.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/30/25.
//

import Foundation

public class CreateIgnoreCacheSessionConfig: CreateUrlSessionConfigInterface {
    
    public init() {
        
    }
    
    public func createConfig(timeoutIntervalForRequest: TimeInterval = 60) -> URLSessionConfiguration {
        
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
