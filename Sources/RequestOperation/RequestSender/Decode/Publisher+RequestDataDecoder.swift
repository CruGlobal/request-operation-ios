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
    
    public func decodeRequestDataResponseForSuccessCodable<SuccessCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, NoResponseCodable>, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            let successCodable: SuccessCodable?
            let failureCodable: NoResponseCodable = NoResponseCodable()
            
            if response.urlResponse.isSuccessHttpStatusCode {
                                
                do {
                    
                    let object: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: response.data)
                    
                    successCodable = object
                }
                catch let decodeError {
                    
                    successCodable = nil
                    
                    throw decodeError
                }
            }
            else {
                
                successCodable = nil
            }
            
            return RequestCodableResponse(
                successCodable: successCodable,
                failureCodable: failureCodable,
                requestDataResponse: response
            )
        }
        .mapError { (decodeError: Error) in
            return decodeError
        }
        .eraseToAnyPublisher()
    }
    
    public func decodeRequestDataResponseForSuccessOrFailureCodable<SuccessCodable: Codable, FailureCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, FailureCodable>, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            let successCodable: SuccessCodable?
            let failureCodable: FailureCodable?
            
            if response.urlResponse.isSuccessHttpStatusCode {
                
                failureCodable = nil
                
                do {
                    
                    let object: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: response.data)
                    
                    successCodable = object
                }
                catch let decodeError {
                    
                    successCodable = nil
                    
                    throw decodeError
                }
            }
            else {
                
                successCodable = nil
                
                do {
                    
                    let object: FailureCodable? = try decoder.decode(FailureCodable.self, from: response.data)
                    
                    failureCodable = object
                }
                catch let decodeError {
                    
                    failureCodable = nil
                    
                    throw decodeError
                }
            }
            
            return RequestCodableResponse(
                successCodable: successCodable,
                failureCodable: failureCodable,
                requestDataResponse: response
            )
        }
        .mapError { (decodeError: Error) in
            return decodeError
        }
        .eraseToAnyPublisher()
    }
}
