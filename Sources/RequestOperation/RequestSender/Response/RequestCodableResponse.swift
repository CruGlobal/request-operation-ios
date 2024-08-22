//
//  RequestCodableResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct RequestCodableResponse<T: Codable, U: Codable> {
    
    public let successObject: T?
    public let failureObject: U?
    public let requestDataResponse: RequestDataResponse
    
    public init(successObject: T?, failureObject: U?, requestDataResponse: RequestDataResponse) {
    
        self.successObject = successObject
        self.failureObject = failureObject
        self.requestDataResponse = requestDataResponse
    }
    
    public var httpStatusCode: Int? {
        return requestDataResponse.urlResponse.httpStatusCode
    }
}
