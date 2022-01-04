//
//  RequestResponseError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public enum RequestResponseError: Error {
    
    case httpClientError(httpStatusCode: Int)
    case requestCancelled
    case noNetworkConnection
    case notAuthorized
    case requestError(error: Error)
    
    public var errorMessage: String {
        
        switch self {
            
        case .httpClientError(let httpStatusCode):
            return "Http Client Error: \(httpStatusCode)"
                        
        case .requestCancelled:
            return "Request Cancelled"
            
        case .noNetworkConnection:
            return "No Network Connection"
            
        case .notAuthorized:
            return "Not Authorized"
            
        case .requestError(let error):
            return "Error: \(error.localizedDescription)"
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
}
