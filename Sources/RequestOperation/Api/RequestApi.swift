//
//  RequestApi.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class RequestApi {
        
    public let context: RequestApiSharedContext
    public let resources: [ApiResource]
    
    public init(context: RequestApiSharedContext, resources: [ApiResource]) {
        
        self.context = context
        self.resources = resources
    }
}
