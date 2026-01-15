//
//  RequestDataResponse+ToError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

extension RequestDataResponse {
    
    public static let toErrorDomain: String = "RequestDataResponse"
    public static let toErrorLocalizedRequestDataResponseKey: String = "RequestDataResponse.toErrorLocalizedRequestDataResponseKey"
    
    public func toError() -> Error {
        
        let errorCode: Int
        let errorDescription: String
        
        if let httpStatusCode = urlResponse.httpStatusCode {
            
            errorCode = httpStatusCode
            errorDescription = "The request failed with httpStatusCode \(httpStatusCode)."
        }
        else {
            
            errorCode = 0
            errorDescription = "The request failed with a null httpStatusCode."
        }
        
        let error: Error = NSError(
            domain: RequestDataResponse.toErrorDomain,
            code: errorCode,
            userInfo: [
                NSLocalizedDescriptionKey: errorDescription,
                RequestDataResponse.toErrorLocalizedRequestDataResponseKey: self
            ]
        )

        return error
    }
}

extension Error {
    
    public var isRequestDataResponse: Bool {
        
        return (self as NSError).domain == RequestDataResponse.toErrorDomain
    }
    
    public func getRequestDataResponse() -> RequestDataResponse? {
        
        let userInfo: [String: Any] = (self as NSError).userInfo
        
        return userInfo[RequestDataResponse.toErrorLocalizedRequestDataResponseKey] as? RequestDataResponse
    }
}
