//
//  URLError+ToError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

extension URLError {
    
    public static let toErrorDomain: String = "URLError"
    public static let toErrorLocalizedUrlErrorKey: String = "URLError.toErrorLocalizedUrlErrorKey"
    
    public func toError() -> Error {
        
        let error: Error = NSError(
            domain: URLError.toErrorDomain,
            code: code.rawValue,
            userInfo: [
                NSLocalizedDescriptionKey: localizedDescription,
                URLError.toErrorLocalizedUrlErrorKey: self
            ]
        )

        return error
    }
}

extension Error {
    
    public var isUrlError: Bool {
        
        return (self as NSError).domain == URLError.toErrorDomain
    }
    
    public func getUrlError() -> URLError? {
        
        let userInfo: [String: Any] = (self as NSError).userInfo
        
        return userInfo[URLError.toErrorLocalizedUrlErrorKey] as? URLError
    }
}
