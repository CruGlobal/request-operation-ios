//
//  ApiEndpointContext.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class ApiEndpointContext {
    
    public let baseUrl: RequestBaseUrl
    public let requestSender: RequestSender
    public let urlSession: URLSession
    
    public init(baseUrl: RequestBaseUrl, requestSender: RequestSender, urlSession: URLSession = RequestUrlSession.ignoreCacheSession) {
        
        self.baseUrl = baseUrl
        self.requestSender = requestSender
        self.urlSession = urlSession
    }
}
