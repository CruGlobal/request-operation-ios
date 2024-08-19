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
    public let requestController: RequestController
    
    public init(baseUrl: ApiBaseUrl, session: URLSession, requestController: RequestController) {
       
        self.baseUrl = baseUrl
        self.session = session
        self.requestController = requestController
    }
}
