//
//  URLSessionPriority.swift
//  RequestOperation
//
//  Created by Rachael Skeath on 5/30/25.
//

import Foundation

public final class URLSessionPriority: Sendable {
    
    private let lowPriorityQueue: URLSessionQueue
    private let mediumPriorityQueue: URLSessionQueue
    private let highPriorityQueue: URLSessionQueue
    
    public init(
        urlSessionConfigCreator: CreateUrlSessionConfigInterface? = nil,
        timeoutIntervalForRequest: TimeInterval = CreateIgnoreCacheSessionConfig.defaultTimeoutIntervalForRequest
    ) {
        
        let createUrlSessionConfig: CreateUrlSessionConfigInterface = urlSessionConfigCreator ?? CreateIgnoreCacheSessionConfig()
        
        lowPriorityQueue = URLSessionQueue(
            qualityOfService: .background,
            sessionDescription: "Low Priority Queue",
            configuration: createUrlSessionConfig.createConfig(timeoutIntervalForRequest: timeoutIntervalForRequest)
        )
        
        mediumPriorityQueue = URLSessionQueue(
            qualityOfService: .utility,
            sessionDescription: "Medium Priority Queue",
            configuration: createUrlSessionConfig.createConfig(timeoutIntervalForRequest: timeoutIntervalForRequest)
        )
        
        highPriorityQueue = URLSessionQueue(
            qualityOfService: .userInitiated,
            sessionDescription: "High Priority Queue",
            configuration: createUrlSessionConfig.createConfig(timeoutIntervalForRequest: timeoutIntervalForRequest)
        )
    }
    
    public func getURLSession(priority: RequestPriority) -> URLSession {
        switch priority {
        case .low:
            return lowPriorityQueue.getUrlSession()
        case .medium:
            return mediumPriorityQueue.getUrlSession()
        case .high:
            return highPriorityQueue.getUrlSession()
        }
    }
}
