//
//  RequestBuilder.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public class RequestBuilder {
    
    public init() {
        
    }
    
    public func build(session: URLSession, urlString: String, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?, queryItems: [URLQueryItem]?) -> URLRequest {
        
        let url: URL?
        
        if let queryItems = queryItems, queryItems.count > 0 {
            
            var urlComponents: URLComponents? = URLComponents(string: urlString)
            urlComponents?.queryItems = queryItems
            
            url = urlComponents?.url
        }
        else {
            
            url = URL(string: urlString)
        }
        
        if let url = url {
            let result: Result<URLRequest, Error> = build(session: session, url: url, method: method, headers: headers, httpBody: httpBody)
            switch result {
            case .success(let request):
                return request
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                return URLRequest(url: url)
            }
        }
        else {
            let errorDescription: String = "Failed to build url with string: \(urlString)"
            assertionFailure(errorDescription)
            return URLRequest(url: url!)
        }
    }
    
    public func build(session: URLSession, url: URL, method: RequestMethod, headers: [String: String]?, httpBody: [String: Any]?) -> Result<URLRequest, Error> {
        
        let configuration = session.configuration
        
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: configuration.requestCachePolicy,
            timeoutInterval: configuration.timeoutIntervalForRequest
        )
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        
        if let httpBody = httpBody {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: httpBody, options: [])
            }
            catch let error {
                return .failure(error)
            }
        }
    
        return .success(urlRequest)
    }
}
