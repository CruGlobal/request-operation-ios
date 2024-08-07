//
//  RequestUrlSession.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public class RequestUrlSession {
    
    public static let sharedIgnoreCacheSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: 60)
    
    public static func createIgnoreCacheSession(timeoutIntervalForRequest: TimeInterval = 60) -> URLSession {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
            
        return URLSession(configuration: configuration)
    }
}
