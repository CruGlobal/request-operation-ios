//
//  RequestResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public class RequestResponse {
            
    public let urlRequest: URLRequest?
    public let data: Data?
    public let urlResponse: URLResponse?
    public let requestError: Error?
    
    public init(urlRequest: URLRequest?, data: Data?, urlResponse: URLResponse?, requestError: Error?) {
                
        self.urlRequest = urlRequest
        self.data = data
        self.urlResponse = urlResponse
        self.requestError = requestError
    }
    
    public var httpStatusCode: Int? {
        return (urlResponse as? HTTPURLResponse)?.statusCode
    }
    
    public var requestErrorCode: Int? {
        return (requestError as NSError?)?.code ?? nil
    }
    
    #if os(iOS)
    public var requestCancelled: Bool {
        return requestErrorCode == Int(CFNetworkErrors.cfurlErrorCancelled.rawValue)
    }
    
    public var notConnectedToInternet: Bool {
        return requestErrorCode == Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue)
    }
    #endif
    
    public func getRequestError() -> RequestError? {
        
        if requestCancelled {
            return .requestCancelled
        }
        else if notConnectedToInternet {
            return .noNetworkConnection
        }
        else if let httpStatusCode = httpStatusCode, httpStatusCode == 401 {
            return .notAuthorized
        }
        else if let httpStatusCode = httpStatusCode, httpStatusCode >= 400 {
            return .httpClientError(httpStatusCode: httpStatusCode)
        }
        else if let error = requestError {
            return .requestError(error: error)
        }
        
        return nil
    }
}

