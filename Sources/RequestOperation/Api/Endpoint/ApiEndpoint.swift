//
//  ApiEndpoint.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

open class ApiEndpoint {
    
    public let resourceUrl: ApiResourceUrl
    public let requestController: RequestController
    
    public convenience init(resourceUrl: ApiResourceUrl, context: RequestApiSharedContext) {
        
        self.init(
            resourceUrl: resourceUrl,
            requestController: context.requestController
        )
    }
    
    public init(resourceUrl: ApiResourceUrl, requestController: RequestController) {
        
        self.resourceUrl = resourceUrl
        self.requestController = requestController
    }
}
