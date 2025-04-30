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
    public let urlSession: URLSession
    public let requestController: RequestController
    
    public init(baseUrl: ApiBaseUrl, urlSession: URLSession, requestController: RequestController) {
       
        self.baseUrl = baseUrl
        self.urlSession = urlSession
        self.requestController = requestController
    }
}
