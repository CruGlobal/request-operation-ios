//
//  URLSessionQueue.swift
//  RequestOperation
//
//  Created by Rachael Skeath on 5/30/25.
//

import Foundation

public class URLSessionQueue {
    
    private let operationQueue: OperationQueue
    private let urlSession: URLSession
    
    public init(qualityOfService: QualityOfService, maxConcurrentOperationCount: Int = 1, sessionDescription: String? = nil, configuration: URLSessionConfiguration = CreateIgnoreCacheSessionConfig().createConfig(timeoutIntervalForRequest: 60)) {
        
        operationQueue = OperationQueue()
        operationQueue.qualityOfService = qualityOfService
        operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
        
        urlSession = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: operationQueue
        )
        urlSession.sessionDescription = sessionDescription
    }
    
    public func getUrlSession() -> URLSession {
        return urlSession
    }
}
