//
//  RequestCodableResponseError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public enum RequestCodableResponseError: Error {
    
    case decoderError(decoderError: Error)
    case urlError(urlError: URLError)
}

extension RequestCodableResponseError {
    
    public func getError() -> Error {
        
        switch self {
        
        case .decoderError(let decoderError):
            return decoderError
        
        case .urlError(let urlError):
            return urlError
        }
    }
    
    public func getErrorDescription() -> String {
        
        switch self {
        
        case .decoderError(let decoderError):
            return decoderError.localizedDescription
        
        case .urlError(let urlError):
            return urlError.localizedDescription
        }
    }
}
