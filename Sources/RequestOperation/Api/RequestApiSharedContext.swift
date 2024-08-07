//
//  RequestApiSharedContext.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/6/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class RequestApiSharedContext {
    
    public let baseUrl: ApiBaseUrl
    public let session: URLSession
    public let requestBuilder: RequestBuilder
    public let requestSender: RequestSender
    
    public init(baseUrl: ApiBaseUrl, session: URLSession, requestBuilder: RequestBuilder, requestSender: RequestSender) {
       
        self.baseUrl = baseUrl
        self.session = session
        self.requestBuilder = requestBuilder
        self.requestSender = requestSender
    }
}
