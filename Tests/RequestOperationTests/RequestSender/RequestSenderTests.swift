//
//  RequestSenderTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/13/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Testing
@testable import RequestOperation
import Foundation

struct RequestSenderTests {
    
    let urlSession: URLSession = CreateUrlSession().createIgnoreCacheSession(timeoutIntervalForRequest: 10)
    let languagesUrl: String = "https://mobile-content-api-stage.cru.org/languages"
    let englishLanguageId: String = "4"
    let invalidLanguageId: String = "32984724"
    
    @Test
    func sendDataIsSuccessfulHttpStatusCode() async throws {
        
        let requestSender = RequestSender()
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: englishLanguageId
        )
        
        let response = try await requestSender.sendDataTask(urlRequest: urlRequest, urlSession: urlSession)
        
        #expect(response.urlResponse.isSuccessHttpStatusCode == true)
    }
    
    @Test
    func sendDataIsUnSuccessfulHttpStatusCode() async throws {
        
        let requestSender = RequestSender()
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: invalidLanguageId
        )
        
        let response = try await requestSender.sendDataTask(urlRequest: urlRequest, urlSession: urlSession)
        
        #expect(response.urlResponse.isSuccessHttpStatusCode == false)
    }
}

extension RequestSenderTests {
    
    func getLanguageUrlRequest(languageId: String) throws -> URLRequest {
        
        let urlString: String = languagesUrl + "/" + languageId
        
        return try getLanguageUrlRequest(urlString: urlString)
    }
    
    func getLanguageUrlRequest(urlString: String) throws -> URLRequest {
                
        let requestBuilder = RequestBuilder()
        
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
        
        return urlRequest
    }
}
