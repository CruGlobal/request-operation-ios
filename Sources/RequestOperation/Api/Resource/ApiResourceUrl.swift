//
//  ApiResourceUrl.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/6/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct ApiResourceUrl {
    
    public let baseUrl: ApiBaseUrl
    public let path: String
    
    public init(baseUrl: ApiBaseUrl, path: String) {
        
        self.baseUrl = baseUrl
        self.path = path
    }
    
    public var absoluteUrl: String {
        return baseUrl.absoluteUrl + "/" + path
    }
}
