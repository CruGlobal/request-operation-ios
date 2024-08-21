//
//  File.swift
//  
//
//  Created by Levi Eggert on 8/21/24.
//

import Foundation

extension URLError {
    
    public func toError() -> Error {
        
        return NSError.createErrorWithDomain(domain: "URLError", code: code.rawValue, description: localizedDescription)
    }
}
