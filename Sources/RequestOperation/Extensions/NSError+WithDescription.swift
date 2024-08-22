//
//  NSError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

extension NSError {
    
    public static func createErrorWithDescription(description: String) -> NSError {
        
        return NSError.createErrorWithDomain(domain: "", code: 0, description: description)
    }
    
    public static func createErrorWithDomain(domain: String, code: Int, description: String) -> NSError {
        
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    public static func createUserCancelledError(domain: String = "") -> NSError {
        return NSError.createErrorWithDomain(domain: domain, code: NSUserCancelledError, description: "User Cancelled")
    }
}
