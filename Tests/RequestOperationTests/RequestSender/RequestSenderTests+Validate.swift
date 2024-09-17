//
//  RequestSenderTests+Validate.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation
import Combine

extension RequestSenderTests {
    
    func testValidateThrowsErrorWhenResponseHttpStatusCodeFallsOutsideOfValidateRange() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.invalidLanguageId
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        let httpStatusCodeSuccessRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange
        
        var errorRef: Error?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
            .validate(successRange: httpStatusCodeSuccessRange)
            .sink { completion in
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    errorRef = error
                }
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        let responseRef: RequestDataResponse? = errorRef?.getRequestDataResponse()
        
        XCTAssertNotNil(errorRef)
        XCTAssertNotNil(responseRef)
        XCTAssertTrue(errorRef!.isRequestDataResponse)
        XCTAssertTrue((errorRef as? NSError)?.domain == RequestDataResponse.toErrorDomain)
        XCTAssertNotNil(responseRef?.urlResponse.httpStatusCode)
        XCTAssertTrue(!httpStatusCodeSuccessRange.contains(responseRef!.urlResponse.httpStatusCode!))
    }
    
    func testValidateIsSuccessfulWhenResponseHttpStatusCodeFallsWithinValidateRange() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.englishLanguageId
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        let httpStatusCodeSuccessRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange
        
        var responseRef: RequestDataResponse?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
            .validate(successRange: httpStatusCodeSuccessRange)
            .sink { completion in
                
                switch completion {
                case .finished:
                    break
                    
                case .failure( _):
                    break
                }
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef?.urlResponse.httpStatusCode)
        XCTAssertTrue(httpStatusCodeSuccessRange.contains(responseRef!.urlResponse.httpStatusCode!))
    }
}
