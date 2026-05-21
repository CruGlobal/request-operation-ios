//
//  RequestSender.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public final class RequestSender: Sendable {
            
    public init() {
        
    }
    
    public func sendDataTask(urlRequest: URLRequest, urlSession: URLSession) async throws -> RequestDataResponse {
        
        do {
            
            let tuple: (data: Data, response: URLResponse) = try await urlSession.data(for: urlRequest)
            
            let response = RequestDataResponse(
                data: tuple.data,
                urlResponse: tuple.response
            )
            
            return response
        }
        catch let error {
            
            if let urlError = error as? URLError {
                throw urlError.toError()
            }
            
            throw error
        }
    }
}
