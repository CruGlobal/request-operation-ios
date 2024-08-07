//
//  ApiResource.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/6/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class ApiResource {
    
    public let resourceUrl: ApiResourceUrl
    public let endpoints: [ApiEndpoint]
    
    public init(resourceUrl: ApiResourceUrl, endpoints: [ApiEndpoint], context: RequestApiSharedContext) {
        
        self.resourceUrl = resourceUrl
        self.endpoints = endpoints
    }
}
