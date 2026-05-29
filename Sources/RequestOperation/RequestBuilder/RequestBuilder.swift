//
//  RequestBuilder.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public final class RequestBuilder: Sendable {
    
    public let requestMutators: [RequestMutator]
    
    public init(requestMutators: [RequestMutator] = Array()) {
        
        self.requestMutators = requestMutators
    }
    
    public init(requestBuilder: RequestBuilder, requestMutators: [RequestMutator]?) {
        
        self.requestMutators = requestMutators ?? requestBuilder.requestMutators
    }
    
    public func clone(requestMutators: [RequestMutator]? = nil) -> RequestBuilder {
        
        return RequestBuilder(requestBuilder: self, requestMutators: requestMutators ?? self.requestMutators)
    }
    
    public func build(parameters: RequestBuilderParameters) throws -> URLRequest {
        
        let url: URL?
        
        if let queryItems = parameters.queryItems, queryItems.count > 0 {
            
            var urlComponents: URLComponents? = URLComponents(string: parameters.urlString)
            
            urlComponents?.queryItems = queryItems
            
            url = urlComponents?.url
        }
        else {
            
            url = URL(string: parameters.urlString)
        }
        
        guard let url = url else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to build url with string: \(parameters.urlString)"])
        }
        
        return build(
            url: url,
            parameters: parameters
        )
    }
    
    public func build(url: URL, parameters: RequestBuilderParameters) -> URLRequest {
                
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: parameters.requestCachePolicy,
            timeoutInterval: parameters.timeoutIntervalForRequest
        )
        
        if let headers = parameters.headers, !headers.isEmpty {
            
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        urlRequest.httpMethod = parameters.method.rawValue
        urlRequest.httpBody = parameters.httpBody
        
        for requestMutator in requestMutators {
            requestMutator.mutate(request: &urlRequest, parameters: parameters)
        }
    
        return urlRequest
    }
}

extension RequestBuilder: Equatable {
    
    public static func == (lhs: RequestBuilder, rhs: RequestBuilder) -> Bool {
        
        guard lhs.requestMutators.count == rhs.requestMutators.count else {
            return false
        }
            
        for index in 0 ..< lhs.requestMutators.count {
            
            let mutatorA: RequestMutator = lhs.requestMutators[index]
            let mutatorB: RequestMutator = rhs.requestMutators[index]
                        
            if type(of: mutatorA) != type(of: mutatorB) {
                return false
            }
        }
        
        return true
    }
}
