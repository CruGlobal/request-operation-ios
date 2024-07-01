//
//  RequestDataResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct RequestDataResponse {
    
    public let data: Data
    public let urlResponse: URLResponse
    
    public init(data: Data, urlResponse: URLResponse) {
        
        self.data = data
        self.urlResponse = urlResponse
    }
    
    public func getDataString() -> String? {
        return String(data: data, encoding: .utf8)
    }
}
