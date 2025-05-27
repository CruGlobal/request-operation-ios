//
//  RequestOperationTests.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/27/25.
//

import XCTest
@testable import RequestOperation

class RequestOperationTests: XCTestCase {
    
    func testSendUrlRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
                
        let urlRequest: URLRequest = RequestSenderTests.buildGetLanguageUrlRequest(
            urlSession: urlSession,
            languageId: RequestSenderTests.englishLanguageId
        )
        
        let queue = OperationQueue()
        
        let requestOperation = RequestOperation(
            session: urlSession,
            urlRequest: urlRequest
        )
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestOperationResponse?
        
        requestOperation.setCompletionHandler { (response: RequestOperationResponse) in
            
            responseRef = response
            
            expectation.fulfill()
        }
        
        queue.addOperations([requestOperation], waitUntilFinished: false)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertTrue(responseRef!.requestDataResponse!.urlResponse.isSuccessHttpStatusCode)
    }
    
    func testSendUrlRequestIsUnSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
                
        let urlRequest: URLRequest = RequestSenderTests.buildGetLanguageUrlRequest(
            urlSession: urlSession,
            languageId: RequestSenderTests.invalidLanguageId
        )
        
        let queue = OperationQueue()
        
        let requestOperation = RequestOperation(
            session: urlSession,
            urlRequest: urlRequest
        )
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestOperationResponse?
        
        requestOperation.setCompletionHandler { (response: RequestOperationResponse) in
            
            responseRef = response
            
            expectation.fulfill()
        }
        
        queue.addOperations([requestOperation], waitUntilFinished: false)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertFalse(responseRef!.requestDataResponse!.urlResponse.isSuccessHttpStatusCode)
    }
}
