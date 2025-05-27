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
            
            return try response.decodeRequestDataResponseForSuccessCodable(
                decoder: decoder
            )
        }
        .eraseToAnyPublisher()
    }
    
    public func decodeRequestDataResponseForSuccessOrFailureCodable<SuccessCodable: Codable, FailureCodable: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<SuccessCodable, FailureCodable>, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            return try response.decodeRequestDataResponseForSuccessOrFailureCodable(
                decoder: decoder
            )
        }
        .eraseToAnyPublisher()
    }
}
