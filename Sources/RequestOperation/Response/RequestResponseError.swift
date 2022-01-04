//
//  RequestResponseError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public enum RequestResponseError<HttpClientErrorResponseType: Decodable>: Error {
    
    case httpClientError(httpClientResponse: HttpClientErrorResponseType?, httpClientResponseDecodeError: Error?, httpStatusCode: Int)
    case noNetworkConnection
    case notAuthorized
    case requestCancelled
    case requestError(error: Error)
    case serverError(httpStatusCode: Int)
    
    public var errorMessage: String {
        
        switch self {
            
        case .httpClientError( _, _, let httpStatusCode):
            return "Http Client Error:\n  httpStatusCode: \(httpStatusCode)"
                        
        case .noNetworkConnection:
            return "No Network Connection"
            
        case .notAuthorized:
            return "Not Authorized"
            
        case .requestCancelled:
            return "Request Cancelled"
            
        case .requestError(let error):
            return "Error: \(error.localizedDescription)"
            
        case .serverError(let httpStatusCode):
            return "Server Error:\n  httpStatusCode: \(httpStatusCode)"
        }
    }
    
    public var notAuthorized: Bool {
        
        switch self {
        case .notAuthorized:
            return true
            
        default:
            return false
        }
    }
    
    public var requestCancelled: Bool {
        
        switch self {
        case .requestCancelled:
            return true
            
        default:
            return false
        }
    }
}
