//
//  UrlRequestResponseError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/18/2023.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public enum UrlRequestResponseError: Error {
    
    case decodeError(error: Error)
    case httpStatusCodeError(urlRequestResponse: UrlRequestResponse)
    case urlError(urlError: URLError)
}

extension UrlRequestResponseError {
    
    public var cancelled: Bool {
        
        switch self {
        case .decodeError( _):
            return false
        case .httpStatusCodeError( _):
            return false
        case .urlError(let urlError):
            return urlError.code == URLError.Code.cancelled
        }
    }
    
    public var error: Error {
        
        switch self {
        case .decodeError(let error):
            return error
        case .httpStatusCodeError(let urlRequestResponse):
            let errorDescription: String = "Failed with http status code error.  Http status code: \(urlRequestResponse.urlResponse.httpStatusCode ?? 0)"
            return NSError(domain: "Http Status Code Error", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        case .urlError(let urlError):
            return NSError(domain: URLError.errorDomain, code: urlError.errorCode)
        }
    }
    
    public var errorDescription: String {
        return error.localizedDescription
    }
    
    public var httpStatusCode: Int? {
        
        switch self {
        case .decodeError( _):
            return nil
        case .httpStatusCodeError(let urlRequestResponse):
            return urlRequestResponse.urlResponse.httpStatusCode
        case .urlError( _):
            return nil
        }
    }
    
    public var isDecodeError: Bool {
        
        switch self {
        case .decodeError( _):
            return true
        case .httpStatusCodeError( _):
            return false
        case .urlError( _):
            return false
        }
    }
    
    public var isHttpStatusCodeError: Bool {
        
        switch self {
        case .decodeError( _):
            return false
        case .httpStatusCodeError( _):
            return true
        case .urlError( _):
            return false
        }
    }
    
    public var isUrlError: Bool {
        
        switch self {
        case .decodeError( _):
            return false
        case .httpStatusCodeError( _):
            return false
        case .urlError( _):
            return true
        }
    }
    
    public var notConnectedToInternet: Bool {
        
        switch self {
        case .decodeError( _):
            return false
        case .httpStatusCodeError( _):
            return false
        case .urlError(let urlError):
            return urlError.code == URLError.Code.notConnectedToInternet
        }
    }
    
    public func getResponseData() -> Data? {
        
        switch self {
        case .decodeError( _):
            return nil
        case .httpStatusCodeError(let urlRequestResponse):
            return urlRequestResponse.data
        case .urlError( _):
            return nil
        }
    }
    
    public func getResponseDataUTF8String() -> String? {
        
        switch self {
        case .decodeError( _):
            return nil
        case .httpStatusCodeError(let urlRequestResponse):
            return urlRequestResponse.getDataUTF8String()
        case .urlError( _):
            return nil
        }
    }
}
