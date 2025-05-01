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
        
        let urlSession: URLSession = RequestUrlSession.sharedIgnoreCacheSession
        
        let requestController = RequestController(
            requestBuilder: RequestBuilder(),
            requestSender: RequestSender(),
            requestRetrier: nil
        )
        
        let context = RequestApiSharedContext(
            baseUrl: baseUrl,
            urlSession: urlSession,
            requestController: requestController
        )
        
        languageResource = LanguageResource(context: context)
        
        super.init(
            context: context,
            resources: [languageResource]
        )
    }
}
