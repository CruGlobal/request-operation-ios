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
    var baseUrl: ApiBaseUrl {
        switch self {
        case .staging:
            return ApiBaseUrl(scheme: .https, host: host)
        case .production:
            return ApiBaseUrl(scheme: .https, host: host)
        }
    }
}
