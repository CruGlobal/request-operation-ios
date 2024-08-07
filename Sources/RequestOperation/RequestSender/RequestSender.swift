//
//  RequestSender.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

public class RequestSender {
        
    public let session: URLSession
    
    public init(session: URLSession) {
        
        self.session = session
    }
    
    public func sendDataTaskPublisher(urlRequest: URLRequest) -> AnyPublisher<RequestDataResponse, URLError> {
        
        return session.dataTaskPublisher(for: urlRequest)
            .map { (tuple: (data: Data, response: URLResponse)) in
                RequestDataResponse(
                    data: tuple.data,
                    urlResponse: tuple.response
                )
            }
            .eraseToAnyPublisher()
    }
    
    public func sendAndDecodeDataTaskPublisher<T: Codable>(urlRequest: URLRequest, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<RequestCodableResponse<T>, RequestCodableResponseError> {
        
        return sendDataTaskPublisher(urlRequest: urlRequest)
            .mapError { (urlError: URLError) in
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

