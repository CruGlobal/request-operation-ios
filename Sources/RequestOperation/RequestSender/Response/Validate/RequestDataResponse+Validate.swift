//
//  RequestDataResponse+Validate.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/26/25.
//

import Foundation

extension RequestDataResponse {
    
    func validate() throws -> RequestDataResponse {
        
        guard let httpStatusCode = urlResponse.httpStatusCode, URLResponse.getIsSuccessHttpStatusCode(httpStatusCode: httpStatusCode) else {
            throw toError()
        }
        
        return self
    }
}
