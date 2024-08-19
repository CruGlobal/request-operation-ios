//
//  RequestBuilder.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public class RequestBuilder {
    
    private let requestMutators: [RequestMutator]
    
    public init(requestMutators: [RequestMutator] = Array()) {
        
        self.requestMutators = requestMutators
    }
    
    public init(requestBuilder: RequestBuilder, requestMutators: [RequestMutator]?) {
        
        self.requestMutators = requestMutators ?? requestBuilder.requestMutators
    }
    
    public func clone(requestMutators: [RequestMutator] = Array()) -> RequestBuilder {
        
        return RequestBuilder(requestBuilder: self, requestMutators: requestMutators)
    }
    
    public func build(parameters: RequestBuilderParameters) -> URLRequest {
        
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
    
    public func build(url: URL, parameters: RequestBuilderParameters) -> Result<URLRequest, Error> {
                
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
