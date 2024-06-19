//
//  RequestBaseUrl.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct RequestBaseUrl {
    
    public let scheme: RequestUrlScheme
    public let host: String
    public let absoluteUrl: String
    public let url: URL?
    
    public init(scheme: RequestUrlScheme, host: String) {
        
        self.scheme = scheme
        self.host = host
        self.absoluteUrl = scheme.rawValue + "://" + host
        self.url = URL(string: absoluteUrl)
    }
}
