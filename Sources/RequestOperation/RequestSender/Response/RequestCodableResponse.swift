//
//  RequestCodableResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public final class RequestCodableResponse<SuccessCodable: Codable & Sendable, FailureCodable: Codable & Sendable>: Sendable {
    
    public let successCodable: SuccessCodable?
    public let failureCodable: FailureCodable?
    public let requestDataResponse: RequestDataResponse
    
    public init(successCodable: SuccessCodable?, failureCodable: FailureCodable?, requestDataResponse: RequestDataResponse) {
    
        self.successCodable = successCodable
        self.failureCodable = failureCodable
        self.requestDataResponse = requestDataResponse
    }
    
    public var httpStatusCode: Int? {
        return requestDataResponse.urlResponse.httpStatusCode
    }
}
