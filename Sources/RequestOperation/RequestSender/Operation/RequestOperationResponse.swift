//
//  RequestOperationResponse.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/27/25.
//

import Foundation

open class RequestOperationResponse {

    public let urlRequest: URLRequest
    public let requestDataResponse: RequestDataResponse?    
    public let requestError: Error?
    
    init(urlRequest: URLRequest, requestDataResponse: RequestDataResponse?, requestError: Error?) {
        
        self.urlRequest = urlRequest
        self.requestDataResponse = requestDataResponse
        self.requestError = requestError
    }
}
