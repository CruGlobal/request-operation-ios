//
//  MobileContentApiHeaders.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import RequestOperation

class MobileContentApiHeaders {
    
    static let defaultAuthorizationKey: String = "Authorization"
    static let defaultContentTypeKey: String = "Content-Type"
    static let defaultContentTypeValue: String = "application/vnd.api+json"
    
    let authorizationKey: String
    let authorizationValue: String?
    let contentTypeKey: String
    let contentTypeValue: String?
    let additionalHeaders: [String: String]?
    
    convenience init(authorizationValue: String? = nil, contentTypeValue: String = MobileContentApiHeaders.defaultContentTypeValue, additionalHeaders: [String: String]? = nil) {
        
        self.init(
            authorizationKey: MobileContentApiHeaders.defaultAuthorizationKey,
            authorizationValue: authorizationValue,
            contentTypeKey: MobileContentApiHeaders.defaultContentTypeKey,
            contentTypeValue: contentTypeValue,
            additionalHeaders: nil
        )
    }
    
    init(authorizationKey: String, authorizationValue: String?, contentTypeKey: String, contentTypeValue: String?, additionalHeaders: [String: String]?) {
            
        self.authorizationKey = authorizationKey
        self.authorizationValue = authorizationValue
        self.contentTypeKey = contentTypeKey
        self.contentTypeValue = contentTypeValue
        self.additionalHeaders = additionalHeaders
    }
    
    static func authorizedHeaders(authorizationValue: String) -> MobileContentApiHeaders {
        return MobileContentApiHeaders(authorizationValue: authorizationValue)
    }
    
    static func nonAuthorizedHeaders() -> MobileContentApiHeaders {
        return MobileContentApiHeaders()
    }
    
    func getHeadersValue() -> [String: String] {
        
        var headers: [String: String] = additionalHeaders ?? Dictionary()
        
        if let contentType = contentTypeValue {
            headers[contentTypeKey] = contentType
        }
        
        if let authorizationValue = authorizationValue {
            headers[authorizationKey] = authorizationValue
        }
        
        return headers
    }
}
