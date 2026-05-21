//
//  RequestDataResponse+Decode.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/27/25.
//

import Foundation

extension RequestDataResponse {
    
    public func decodeRequestDataResponseForSuccessCodable<SuccessCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) throws -> RequestCodableResponse<SuccessCodable, NoResponseCodable> {
        
        guard urlResponse.isSuccessHttpStatusCode else {
            
            return RequestCodableResponse(
                successCodable: nil,
                failureCodable: NoResponseCodable(),
                requestDataResponse: self
            )
        }
        
        let successCodable: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: data)
        
        return RequestCodableResponse(
            successCodable: successCodable,
            failureCodable: NoResponseCodable(),
            requestDataResponse: self
        )
    }
    
    public func decodeRequestDataResponseForSuccessOrFailureCodable<SuccessCodable: Codable, FailureCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) throws -> RequestCodableResponse<SuccessCodable, FailureCodable> {
        
        if urlResponse.isSuccessHttpStatusCode {
            
            let successCodable: SuccessCodable? = try decoder.decode(SuccessCodable.self, from: data)
            
            return RequestCodableResponse(
                successCodable: successCodable,
                failureCodable: nil,
                requestDataResponse: self
            )
        }
        else {
            
            let failureCodable: FailureCodable? = try decoder.decode(FailureCodable.self, from: data)

            return RequestCodableResponse(
                successCodable: nil,
                failureCodable: failureCodable,
                requestDataResponse: self
            )
        }
    }
}
