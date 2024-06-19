//
//  RequestApi.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class RequestApi {
        
    public let baseUrl: RequestBaseUrl
    public let requestSender: RequestSender
    public let endpoints: [ApiEndpoint]
    
    public init(context: ApiEndpointContext, endpoints: [ApiEndpoint]) {
        
        self.baseUrl = context.baseUrl
        self.requestSender = context.requestSender
        self.endpoints = endpoints
    }
}
