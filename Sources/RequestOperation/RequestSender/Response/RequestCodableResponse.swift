//
//  RequestCodableResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct RequestCodableResponse<SuccessCodable: Codable, FailureCodable: Codable> {
    
    public let successResult: Result<SuccessCodable, Error>?
    public let failureResult: Result<FailureCodable, Error>?
    public let requestDataResponse: RequestDataResponse
    
    public init(successResult: Result<SuccessCodable, Error>?, failureResult: Result<FailureCodable, Error>?, requestDataResponse: RequestDataResponse) {
    
        self.successResult = successResult
        self.failureResult = failureResult
        self.requestDataResponse = requestDataResponse
    }
    
    public var successCodable: SuccessCodable? {
        
        guard let successResult = self.successResult else {
            return nil
        }
        
        switch successResult {
        case .success(let successCodable):
            return successCodable
        case .failure( _):
            return nil
        }
    }
    
    public var failureCodable: FailureCodable? {
        
        guard let failureResult = self.failureResult else {
            return nil
        }
        
        switch failureResult {
        case .success(let failureCodable):
            return failureCodable
        case .failure( _):
            return nil
        }
    }
    
    public var httpStatusCode: Int? {
        return requestDataResponse.urlResponse.httpStatusCode
    }
}
