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
    
    public func decodeRequestDataResponse<T: Codable, U: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<T, U>, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            let successObject: T?
            let failureObject: U?
            
            if response.urlResponse.isSuccessHttpStatusCode {
                
                failureObject = nil
                
                do {
                    
                    let object: T? = try decoder.decode(T.self, from: response.data)
                    
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
                    
                    let object: U? = try decoder.decode(U.self, from: response.data)
                    
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
