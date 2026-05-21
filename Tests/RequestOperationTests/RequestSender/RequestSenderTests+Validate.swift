//
//  RequestSenderTests+Validate.swift
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
    func validateFailsWithErrorWhenResponseHttpStatusCodeFallsOutsideOfValidateRange() async throws {
                   
        let urlRequest: URLRequest = try getLanguageUrlRequest(languageId: invalidLanguageId)
        
        let requestSender = RequestSender()
        
        let httpStatusCodeSuccessRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange
        
        let errorRef: Error?
        
        do {
            
            _ = try await requestSender
                .sendDataTask(
                    urlRequest: urlRequest,
                    urlSession: urlSession
                )
                .validate(successRange: httpStatusCodeSuccessRange)
            
            errorRef = nil
        }
        catch let error {
            errorRef = error
        }
        
        let error: Error = try #require(errorRef)
        let response: RequestDataResponse = try #require(error.getRequestDataResponse())
        let httpStatusCode: Int = try #require(response.urlResponse.httpStatusCode)
        
        #expect(error.isRequestDataResponse == true)
        #expect((error as NSError).domain == RequestDataResponse.toErrorDomain)
        #expect(!httpStatusCodeSuccessRange.contains(httpStatusCode))
    }
    
    @Test()
    func validateIsSuccessfulWhenResponseHttpStatusCodeFallsWithinValidateRange() async throws {
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(languageId: englishLanguageId)

        let requestSender = RequestSender()
                
        let httpStatusCodeSuccessRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange
        
        let response = try await requestSender.sendDataTask(urlRequest: urlRequest, urlSession: urlSession)
            .validate(successRange: httpStatusCodeSuccessRange)
        
        let httpStatusCode: Int = try #require(response.urlResponse.httpStatusCode)
        
        #expect(httpStatusCodeSuccessRange.contains(httpStatusCode))
    }
}
