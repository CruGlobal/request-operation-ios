//
//  URLError+ToError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

extension URLError {
    
    public static var toErrorDomain: String = "URLError"
    public static var toErrorLocalizedUrlErrorKey: String = "URLError.toErrorLocalizedUrlErrorKey"
    
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
