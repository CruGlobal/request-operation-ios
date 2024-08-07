//
//  ApiBaseUrl.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/6/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct ApiBaseUrl {
    
    public enum Scheme: String {
        case http = "http"
        case https = "https"
    }
    
    public let scheme: ApiBaseUrl.Scheme
    public let host: String
    
    public init(scheme: ApiBaseUrl.Scheme, host: String) {
        
        self.scheme = scheme
        self.host = host
    }
    
    public var absoluteUrl: String {
        return scheme.rawValue + "://" + host
    }
    
    public var url: URL? {
        return URL(string: absoluteUrl)
    }
}
