//
//  RequestSenderTests+URLError.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation
import Combine

extension RequestSenderTests {
    
    func testSendUrlRequestFailedWithUrlError() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let requestBuilder = RequestBuilder()
        
        let urlWithBadHost: String = "https://37469355108471600907768582811183.com/languages/4"
        let urlString: String = urlWithBadHost
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

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var errorRef: Error?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
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
        XCTAssertNotNil(errorRef?.getUrlError())
        XCTAssertTrue(errorRef!.isUrlError)
        XCTAssertTrue((errorRef as? NSError)?.domain == URLError.toErrorDomain)
    }
}
