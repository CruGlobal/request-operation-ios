//
//  RequestUrlSession.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public final class RequestUrlSession {
    
    public static let sharedIgnoreCacheSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: 60)
    
    public static func createIgnoreCacheSession(timeoutIntervalForRequest: TimeInterval = 60) -> URLSession {
        return URLSession(
            configuration: CreateIgnoreCacheSessionConfig().createConfig(timeoutIntervalForRequest: timeoutIntervalForRequest)
        )
    }
}
