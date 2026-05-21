//
//  CreateUrlSession.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public final class CreateUrlSession: Sendable {
    
    public init() {
        
    }
    
    public func createSession(config: CreateUrlSessionConfigInterface, timeoutIntervalForRequest: TimeInterval) -> URLSession {
        return URLSession(
            configuration: config.createConfig(timeoutIntervalForRequest: timeoutIntervalForRequest)
        )
    }
    
    public func createIgnoreCacheSession(timeoutIntervalForRequest: TimeInterval) -> URLSession {
        return URLSession(
            configuration: CreateIgnoreCacheSessionConfig().createConfig(timeoutIntervalForRequest: timeoutIntervalForRequest)
        )
    }
}
