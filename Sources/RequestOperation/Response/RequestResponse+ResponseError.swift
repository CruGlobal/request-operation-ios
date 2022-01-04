//
//  RequestResponse+Error.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public extension RequestResponse {
    
    func getResponseError() -> RequestResponseError<NoHttpClientErrorResponse>? {
        
        return getDecodedResponseError()
    }
    
    func getDecodedResponseError<HttpClientErrorResponse: Decodable>() -> RequestResponseError<HttpClientErrorResponse>? {
        
        let httpStatusCode: Int? = self.httpStatusCode
        
        if requestCancelled {
            return .requestCancelled
        }
        else if notConnectedToInternet {
            return .noNetworkConnection
        }
        else if let httpStatusCode = httpStatusCode, httpStatusCode == 401 {
            return .notAuthorized
        }
        else if let httpStatusCode = httpStatusCode, httpStatusCode >= 400 && httpStatusCode < 500 {
            
            let httpClientErrorResponse: HttpClientErrorResponse?
            let httpClientResponseDecodeError: Error?
            
            if let data = self.data {
                
                do {
                    
                    let decodedResponse: HttpClientErrorResponse? = try JSONDecoder().decode(HttpClientErrorResponse.self, from: data)
                    
                    httpClientErrorResponse = decodedResponse
                    httpClientResponseDecodeError = nil
                }
                catch let error {
                    
                    httpClientErrorResponse = nil
                    httpClientResponseDecodeError = error
                }
            }
            else {
                
                httpClientErrorResponse = nil
                httpClientResponseDecodeError = nil
            }
            
            return .httpClientError(
                httpClientResponse: httpClientErrorResponse,
                httpClientResponseDecodeError: httpClientResponseDecodeError,
                httpStatusCode: httpStatusCode
            )
        }
        else if let httpStatusCode = httpStatusCode, httpStatusCode >= 500 {
            
            return .serverError(httpStatusCode: httpStatusCode)
        }
        else if let error = requestError {
            
            return .requestError(error: error)
        }
        
        return nil
    }
}
