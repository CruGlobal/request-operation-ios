//
//  URLSessionQueue.swift
//  RequestOperation
//
//  Created by Rachael Skeath on 5/30/25.
//

import Foundation

public final class URLSessionQueue {
    
    private let operationQueue: OperationQueue
    private let urlSession: URLSession
    
    public init(qualityOfService: QualityOfService, sessionDescription: String? = nil, configuration: URLSessionConfiguration = CreateIgnoreCacheSessionConfig().createConfig(timeoutIntervalForRequest: 60)) {
        
        operationQueue = Self.createSerialQueue(
            qualityOfService: qualityOfService
        )
        
        urlSession = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: operationQueue
        )
        urlSession.sessionDescription = sessionDescription
    }
    
    private static func createSerialQueue(qualityOfService: QualityOfService) -> OperationQueue {
        
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = qualityOfService
        operationQueue.maxConcurrentOperationCount = 1
        
        return operationQueue
    }
    
    public func getUrlSession() -> URLSession {
        return urlSession
    }
}
