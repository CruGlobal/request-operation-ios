//
//  MobileContentApi.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import RequestOperation

class MobileContentApi: RequestApi {
    
    let languages: LanguagesEndpoint
    
    init(environment: MobileContentApiEnvironment) {
        
        let context = ApiEndpointContext(
            baseUrl: environment.baseUrl,
            requestSender: RequestSender()
        )
        
        languages = LanguagesEndpoint(path: "languages", context: context)
        
        super.init(
            context: context,
            endpoints: [
                languages
            ]
        )
    }
}
