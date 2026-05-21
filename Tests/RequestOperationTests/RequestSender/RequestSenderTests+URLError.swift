//
//  RequestSenderTests+URLError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Testing
@testable import RequestOperation
import Foundation

extension RequestSenderTests {
    
    @Test()
    func sendDataTaskUrlErrorToError() async throws {
                                
        let requestBuilder = RequestBuilder()
        
        let urlWithBadHost: String = "https://37469355108471600907768582811183.com/languages/4"
        let urlString: String = urlWithBadHost
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = try requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: urlSession,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: nil
            )
        )

        let requestSender = RequestSender()
        
        let errorRef: Error?
        
        do {
            _ = try await requestSender.sendDataTask(urlRequest: urlRequest, urlSession: urlSession)
            errorRef = nil
        }
        catch let error {
            errorRef = error
        }
        
        let error: Error = try #require(errorRef)
        
        #expect(error.getUrlError() != nil)
        #expect(error.isUrlError == true)
        #expect((error as NSError).domain == URLError.toErrorDomain)
    }
}
