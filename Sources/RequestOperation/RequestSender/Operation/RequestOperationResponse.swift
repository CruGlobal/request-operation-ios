//
//  RequestOperationResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/27/2025.
//  Copyright © 2025 Cru. All rights reserved.
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
