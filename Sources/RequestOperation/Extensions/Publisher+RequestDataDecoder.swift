//
//  Publisher+RequestDataDecoder.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

extension Publisher where Output == RequestDataResponse, Failure == Error {
    
    public func decodeSuccessRequestDataResponse<SuccessCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, NoResponseCodable>, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            let successObject: SuccessCodable?
            let failureObject: NoResponseCodable = NoResponseCodable()
            
            if response.urlResponse.isSuccessHttpStatusCode {
                                
                do {
                    
                    let object: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: response.data)
                    
                    successObject = object
                }
                catch let decodeError {
                    
                    successObject = nil
                    
                    throw decodeError
                }
            }
            else {
                
                successObject = nil
            }
            
            return RequestCodableResponse(
                successObject: successObject,
                failureObject: failureObject,
                requestDataResponse: response
            )
        }
        .mapError { (decodeError: Error) in
            return decodeError
        }
        .eraseToAnyPublisher()
    }
    
    public func decodeSuccessOrFailureRequestDataResponse<SuccessCodable: Codable, FailureCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, FailureCodable>, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            let successObject: SuccessCodable?
            let failureObject: FailureCodable?
            
            if response.urlResponse.isSuccessHttpStatusCode {
                
                failureObject = nil
                
                do {
                    
                    let object: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: response.data)
                    
                    successObject = object
                }
                catch let decodeError {
                    
                    successObject = nil
                    
                    throw decodeError
                }
            }
            else {
                
                successObject = nil
                
                do {
                    
                    let object: FailureCodable? = try decoder.decode(FailureCodable.self, from: response.data)
                    
                    failureObject = object
                }
                catch let decodeError {
                    
                    failureObject = nil
                    
                    throw decodeError
                }
            }
            
            return RequestCodableResponse(
                successObject: successObject,
                failureObject: failureObject,
                requestDataResponse: response
            )
        }
        .mapError { (decodeError: Error) in
            return decodeError
        }
        .eraseToAnyPublisher()
    }
}
