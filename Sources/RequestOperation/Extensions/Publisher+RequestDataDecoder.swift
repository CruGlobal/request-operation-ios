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
    
    public func decodeRequestDataResponse<T: Codable>(decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<T>, RequestCodableResponseError> {
        
        self.mapError { (urlError: URLError) in
            return RequestCodableResponseError.urlError(urlError: urlError)
        }
        .tryMap { (response: RequestDataResponse) in
            
            guard response.urlResponse.isSuccessHttpStatusCode else {
                return RequestCodableResponse(codable: nil, requestDataResponse: response)
            }
            
            do {
                
                let object: T? = try decoder.decode(T.self, from: response.data)
                
                return RequestCodableResponse<T>(
                    codable: object,
                    requestDataResponse: response
                )
            }
            catch let decodeError {
                throw decodeError
            }
        }
        .mapError { (decodeError: Error) in
            RequestCodableResponseError.decoderError(decoderError: decodeError)
        }
        .eraseToAnyPublisher()
    }
}
