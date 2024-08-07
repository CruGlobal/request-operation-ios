//
//  LanguageResource.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 8/6/24.
//

import Foundation
import RequestOperation

class LanguageResource: ApiResource {
    
    let getLanguageEndpoint: GetLanguageEndpoint
    let getLanguagesEndpoint: GetLanguagesEndpoint
    
    init(context: RequestApiSharedContext) {
        
        let resourceUrl = ApiResourceUrl(baseUrl: context.baseUrl, path: "languages")
        
        getLanguageEndpoint = GetLanguageEndpoint(
            resourceUrl: resourceUrl,
            context: context
        )
        
        getLanguagesEndpoint = GetLanguagesEndpoint(
            resourceUrl: resourceUrl,
            context: context
        )
        
        super.init(resourceUrl: resourceUrl, endpoints: [], context: context)
    }
}
