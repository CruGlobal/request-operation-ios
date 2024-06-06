//
//  RequestInterface.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public protocol RequestInterface {
    
    var urlSession: URLSession { get }
    var baseUrl: RequestBaseUrl { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String] { get }
    var httpBody: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension RequestInterface {
    public var absoluteUrl: String {
        return baseUrl.absoluteUrl + "/" + path
    }
}
