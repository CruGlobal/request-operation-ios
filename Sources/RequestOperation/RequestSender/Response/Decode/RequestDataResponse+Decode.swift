//
//  RequestDataResponse+Decode.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/27/25.
//

import Foundation

extension RequestDataResponse {
    
    public func decodeRequestDataResponseForSuccessCodable<SuccessCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) throws -> RequestCodableResponse<SuccessCodable, NoResponseCodable> {
        
        let successCodable: SuccessCodable?
        let failureCodable: NoResponseCodable = NoResponseCodable()
        
        if urlResponse.isSuccessHttpStatusCode {
                            
            do {
                
                let object: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: data)
                
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
        
        let codableResponse = RequestCodableResponse(
            successCodable: successCodable,
            failureCodable: failureCodable,
            requestDataResponse: self
        )
        
        return codableResponse
    }
    
    public func decodeRequestDataResponseForSuccessOrFailureCodable<SuccessCodable: Codable, FailureCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) throws -> RequestCodableResponse<SuccessCodable, FailureCodable> {

        let successCodable: SuccessCodable?
        let failureCodable: FailureCodable?
        
        if urlResponse.isSuccessHttpStatusCode {
            
            failureCodable = nil
            
            do {
                
                let object: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: data)
                
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
                
                let object: FailureCodable? = try decoder.decode(FailureCodable.self, from: data)
                
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
            requestDataResponse: self
        )
    }
}
