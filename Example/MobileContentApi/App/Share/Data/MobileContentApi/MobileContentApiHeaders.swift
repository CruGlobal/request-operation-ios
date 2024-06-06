//
//  MobileContentApiHeaders.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import RequestOperation

class MobileContentApiHeaders: ApiRequestHeaders {
    
    static let defaultContentTypeValue: String = "application/vnd.api+json"
    
    init(authorizationValue: String? = nil, contentTypeValue: String = MobileContentApiHeaders.defaultContentTypeValue) {
        
        super.init(
            authorizationValue: authorizationValue,
            contentTypeValue: contentTypeValue
        )
    }
    
    static func authorizedHeaders(authorizationValue: String) -> MobileContentApiHeaders {
        return MobileContentApiHeaders(authorizationValue: authorizationValue)
    }
    
    static func nonAuthorizedHeaders() -> MobileContentApiHeaders {
        return MobileContentApiHeaders()
    }
}
