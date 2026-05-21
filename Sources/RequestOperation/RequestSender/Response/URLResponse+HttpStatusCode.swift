//
//  URLResponse+HttpStatusCode.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 6/12/2023.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

extension URLResponse {
    
    public static let httpStatusCodeSuccessRange: Range<Int> = 200 ..< 400
    
    public var httpStatusCode: Int? {
        return (self as? HTTPURLResponse)?.statusCode
    }
    
    public var isSuccessHttpStatusCode: Bool {
            
        guard let httpStatusCode = self.httpStatusCode else {
            return false
        }
        
        return Self.getIsSuccessHttpStatusCode(httpStatusCode: httpStatusCode)
    }
    
    public static func getIsSuccessHttpStatusCode(httpStatusCode: Int, successRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange) -> Bool {
        
        return successRange.contains(httpStatusCode)
    }
}
