//
//  File.swift
//  
//
//  Created by Levi Eggert on 8/21/24.
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
