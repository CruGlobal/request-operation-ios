//
//  RequestSenderTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/13/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation
import Combine

class RequestSenderTests: XCTestCase {
 
    static let languagesUrl: String = "https://mobile-content-api-stage.cru.org/languages"
    static let englishLanguageId: String = "4"
    static let invalidLanguageId: String = "-37469355108471600907768582811183"
    
    var cancellables: Set<AnyCancellable> = Set()
    
    func buildGetLanguageUrlRequest(urlSession: URLSession, languageId: String) -> URLRequest {
        
        let requestBuilder = RequestBuilder()
        
        let urlString: String = Self.languagesUrl + "/" + languageId
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = requestBuilder.build(
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
    
    func testSendUrlRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
                
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(urlSession: urlSession, languageId: Self.englishLanguageId)

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestDataResponse?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertTrue(responseRef!.urlResponse.isSuccessHttpStatusCode)
    }
    
    func testSendUrlRequestIsUnSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(urlSession: urlSession, languageId: Self.invalidLanguageId)
        
        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestDataResponse?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertFalse(responseRef!.urlResponse.isSuccessHttpStatusCode)
    }
}
