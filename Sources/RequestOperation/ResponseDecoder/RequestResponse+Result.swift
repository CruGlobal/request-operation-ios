//
//  RequestResponse+Result.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public extension RequestResponse {
        
    func getResult<HttpClientSuccessResponseType: Decodable, HttpClientErrorResponseType: Decodable>() -> RequestResponseResult<HttpClientSuccessResponseType, HttpClientErrorResponseType> {
        
        let responseError: RequestResponseError<HttpClientErrorResponseType>? = getDecodedResponseError()
        
        if let responseError = responseError {
            
            return .failure(responseError: responseError)
        }
        else {
            
            let httpClientSuccessResponse: HttpClientSuccessResponseType?
            let httpClientSuccessResponseDecodeError: Error?
            
            if let data = self.data {
                
                do {
                    
                    let decodedHttpClientSuccessResponse: HttpClientSuccessResponseType? = try JSONDecoder().decode(HttpClientSuccessResponseType.self, from: data)
                    
                    httpClientSuccessResponse = decodedHttpClientSuccessResponse
                    httpClientSuccessResponseDecodeError = nil
                }
                catch let error {
                    
                    httpClientSuccessResponse = nil
                    httpClientSuccessResponseDecodeError = error
                }
            }
            else {
                
                httpClientSuccessResponse = nil
                httpClientSuccessResponseDecodeError = nil
            }
            
            return .success(response: httpClientSuccessResponse, responseDecodeError: httpClientSuccessResponseDecodeError)
        }
    }
}
