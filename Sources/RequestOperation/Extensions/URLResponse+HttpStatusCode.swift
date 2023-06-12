//
//  URLResponse+HttpStatusCode.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 6/12/2023.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

extension URLResponse {
    
    public var httpStatusCode: Int? {
        return (self as? HTTPURLResponse)?.statusCode
    }
    
    public var isSuccessHttpStatusCode: Bool {
            
        guard let httpStatusCode = self.httpStatusCode else {
            return false
        }
        
        return httpStatusCode >= 200 && httpStatusCode < 400
    }
}
