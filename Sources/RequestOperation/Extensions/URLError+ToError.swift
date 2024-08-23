//
//  URLError+ToError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

extension URLError {
    
    public func toError() -> Error {
        
        return NSError.createErrorWithDomain(domain: "URLError", code: code.rawValue, description: localizedDescription)
    }
}
