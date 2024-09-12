//
//  Publisher+RequestDataDecoder.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

extension Publisher where Output == RequestDataResponse, Failure == URLError {
    
    public func decodeRequestDataResponseForSuccessCodable<SuccessCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, NoResponseCodable>, URLError> {
        
        self.map { (response: RequestDataResponse) in
            
            let successResult: Result<SuccessCodable, Error>? = response.urlResponse.isSuccessHttpStatusCode ? self.decodeData(data: response.data, decoder: decoder) : nil
            
            return RequestCodableResponse(
                successResult: successResult,
                failureResult: nil,
                requestDataResponse: response
            )
        }
        .eraseToAnyPublisher()
    }
    
    public func decodeRequestDataResponseForSuccessOrFailureCodable<SuccessCodable: Codable, FailureCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, FailureCodable>, URLError> {
        
        self.map { (response: RequestDataResponse) in
            
            let successResult: Result<SuccessCodable, Error>? = response.urlResponse.isSuccessHttpStatusCode ? self.decodeData(data: response.data, decoder: decoder) : nil
            let failureResult: Result<FailureCodable, Error>? = !response.urlResponse.isSuccessHttpStatusCode ? self.decodeData(data: response.data, decoder: decoder) : nil
            
            return RequestCodableResponse(
                successResult: successResult,
                failureResult: failureResult,
                requestDataResponse: response
            )
        }
        .eraseToAnyPublisher()
    }
    
    private func decodeData<T: Codable>(data: Data, decoder: JSONDecoder) -> Result<T, Error>? {
        
        do {
            
            let object: T? = try decoder.decode(T.self, from: data)
            
            guard let object = object else {
                return nil
            }
            
            return .success(object)
        }
        catch let decodeError {
            
            return .failure(decodeError)
        }
    }
}
