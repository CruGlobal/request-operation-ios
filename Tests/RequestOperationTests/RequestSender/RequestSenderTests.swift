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
 
    private static let englishLanguageUrl: String = "https://mobile-content-api-stage.cru.org/languages/4"
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    func testSendUrlRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let requestBuilder = RequestBuilder()
        
        let urlString: String = Self.englishLanguageUrl
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: session,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: nil
            )
        )

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestDataResponse?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertTrue(responseRef?.urlResponse.isSuccessHttpStatusCode ?? false)
    }
    
    func testSendUrlRequestFailedWithUrlError() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let requestBuilder = RequestBuilder()
        
        let urlWithBadHost: String = "https://37469355108471600907768582811183.com/languages/4"
        let urlString: String = urlWithBadHost
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: session,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: nil
            )
        )

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var errorRef: Error?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
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
        
        XCTAssertNotNil(errorRef)
        XCTAssertTrue(errorRef?.isUrlError ?? false)
        XCTAssertNotNil(errorRef?.getUrlError())
        XCTAssertTrue((errorRef as? NSError)?.domain == URLError.toErrorDomain)
    }
}
