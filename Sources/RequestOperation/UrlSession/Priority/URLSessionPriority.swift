//
//  URLSessionPriority.swift
//  RequestOperation
//
//  Created by Rachael Skeath on 5/30/25.
//

import Foundation

public final class URLSessionPriority {
    
    private let lowPriorityQueue: URLSessionQueue
    private let mediumPriorityQueue: URLSessionQueue
    private let highPriorityQueue: URLSessionQueue
    
    public init() {
        
        lowPriorityQueue = URLSessionQueue(
            qualityOfService: .background,
            sessionDescription: "Low Priority Queue"
        )
        
        mediumPriorityQueue = URLSessionQueue(
            qualityOfService: .utility,
            sessionDescription: "Medium Priority Queue"
        )
        
        highPriorityQueue = URLSessionQueue(
            qualityOfService: .userInitiated,
            sessionDescription: "High Priority Queue"
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
