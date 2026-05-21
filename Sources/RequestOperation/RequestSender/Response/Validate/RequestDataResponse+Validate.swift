//
//  RequestDataResponse+Validate.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/26/25.
//

import Foundation

extension RequestDataResponse {
    
    public func validate(successRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange) throws -> RequestDataResponse {
        
        guard let httpStatusCode = urlResponse.httpStatusCode, URLResponse.getIsSuccessHttpStatusCode(httpStatusCode: httpStatusCode, successRange: successRange) else {
            throw toError()
        }
        
        return self
    }
}
