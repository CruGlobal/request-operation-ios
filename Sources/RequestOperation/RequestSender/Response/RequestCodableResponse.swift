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
    
    public var httpStatusCode: Int? {
        return requestDataResponse.urlResponse.httpStatusCode
    }
    
    public var successCodable: SuccessCodable? {
        return getCodableValue(result: successResult)
    }
    
    public var successCodableDecodeError: Error? {
        return getDecodeErrorValue(result: successResult)
    }
    
    public var failureCodable: FailureCodable? {
        return getCodableValue(result: failureResult)
    }
    
    public var failureCodableDecodeError: Error? {
        return getDecodeErrorValue(result: failureResult)
    }
    
    private func getCodableValue<T: Codable>(result: Result<T, Error>?) -> T? {
        
        guard let result = result else {
            return nil
        }
        
        switch result {
        case .success(let codable):
            return codable
            
        case .failure( _):
            return nil
        }
    }
    
    private func getDecodeErrorValue<T: Codable>(result: Result<T, Error>?) -> Error? {
        
        guard let result = result else {
            return nil
        }
        
        switch result {
        case .success( _):
            return nil
            
        case .failure(let decodeError):
            return decodeError
        }
    }
}
