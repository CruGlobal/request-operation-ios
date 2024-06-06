//
//  MobileContentApiEnvironment.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import RequestOperation

enum MobileContentApiEnvironment {
    
    case staging
    case production
    
    var host: String {
        switch self {
        case .staging:
            return "mobile-content-api-stage.cru.org"
        case .production:
            return "mobile-content-api.cru.org"
        }
    }
}

extension MobileContentApiEnvironment {
    var baseUrl: RequestBaseUrl {
        switch self {
        case .staging:
            return RequestBaseUrl(scheme: .https, host: host)
        case .production:
            return RequestBaseUrl(scheme: .https, host: host)
        }
    }
}
