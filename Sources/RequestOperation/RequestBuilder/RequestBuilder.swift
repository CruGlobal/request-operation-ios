//
//  RequestBuilder.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

open class RequestBuilder {
    
    public let requestMutators: [RequestMutator]
    
    public init(requestMutators: [RequestMutator] = Array()) {
        
        self.requestMutators = requestMutators
    }
    
    public init(requestBuilder: RequestBuilder, requestMutators: [RequestMutator]?) {
        
        self.requestMutators = requestMutators ?? requestBuilder.requestMutators
    }
    
    open func clone(requestMutators: [RequestMutator]? = nil) -> RequestBuilder {
        
        return RequestBuilder(requestBuilder: self, requestMutators: requestMutators ?? self.requestMutators)
    }
    
    open func build(parameters: RequestBuilderParameters) -> URLRequest {
        
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
            
            let errorDescription: String = "Failed to build url with string: \(parameters.urlString)"
            assertionFailure(errorDescription)
            return URLRequest(url: url!)
        }
        
        let result: Result<URLRequest, Error> = build(
            url: url,
            parameters: parameters
        )
        
        switch result {
        
        case .success(let request):
            return request
        
        case .failure(let error):
            assertionFailure(error.localizedDescription)
            return URLRequest(url: url)
        }
    }
    
    open func build(url: URL, parameters: RequestBuilderParameters) -> Result<URLRequest, Error> {
                
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
        
        if let httpBody = parameters.httpBody {
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: httpBody, options: [])
            }
            catch let error {
                return .failure(error)
            }
        }
        
        for requestMutator in requestMutators {
            requestMutator.mutate(request: &urlRequest, parameters: parameters)
        }
    
        return .success(urlRequest)
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
