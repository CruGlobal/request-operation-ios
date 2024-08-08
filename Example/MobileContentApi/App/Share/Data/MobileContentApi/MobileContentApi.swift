//
//  MobileContentApi.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import RequestOperation

class MobileContentApi: RequestApi {
    
    let languageResource: LanguageResource
    
    init(environment: MobileContentApiEnvironment) {
        
        let baseUrl: ApiBaseUrl = environment.baseUrl
        
        let session: URLSession = RequestUrlSession.sharedIgnoreCacheSession
        
        let context = RequestApiSharedContext(
            baseUrl: baseUrl,
            session: session,
            requestBuilder: RequestBuilder(),
            requestSender: RequestSender(session: session)
        )
        
        languageResource = LanguageResource(context: context)
        
        super.init(
            context: context,
            resources: [languageResource]
        )
    }
}
