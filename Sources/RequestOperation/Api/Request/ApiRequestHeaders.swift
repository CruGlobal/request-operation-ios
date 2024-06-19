//
//  ApiRequestHeaders.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

open class ApiRequestHeaders {
        
    public static let defaultAuthorizationKey: String = "Authorization"
    public static let defaultContentTypeKey: String = "Content-Type"
    
    public let authorizationKey: String
    public let authorizationValue: String?
    public let contentTypeKey: String
    public let contentTypeValue: String?
    
    public init(authorizationKey: String = ApiRequestHeaders.defaultAuthorizationKey, authorizationValue: String? = nil, contentTypeKey: String = ApiRequestHeaders.defaultContentTypeKey, contentTypeValue: String? = nil) {
            
        self.authorizationKey = authorizationKey
        self.authorizationValue = authorizationValue
        self.contentTypeKey = contentTypeKey
        self.contentTypeValue = contentTypeValue
    }
    
    func getHeadersValue() -> [String: String] {
        
        var headers: [String: String] = Dictionary()
        
        if let contentType = contentTypeValue {
            headers[contentTypeKey] = contentType
        }
        
        if let authorizationValue = authorizationValue {
            headers[authorizationKey] = authorizationValue
        }
        
        return headers
    }
}
