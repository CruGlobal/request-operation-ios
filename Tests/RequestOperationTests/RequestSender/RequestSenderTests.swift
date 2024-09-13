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
 
    private var cancellables: Set<AnyCancellable> = Set()
    
    func testSendUrlRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let requestBuilder = RequestBuilder()
        
        let urlString: String = "https://mobile-content-api-stage.cru.org/languages/4"
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
        
        let rawData: String? = responseRef?.getDataString()
        let httpStatusCode: Int? = responseRef?.urlResponse.httpStatusCode
        
        print(rawData ?? "")
        print(httpStatusCode ?? -1)
        
        XCTAssertNotNil(responseRef)
        XCTAssertTrue(responseRef?.urlResponse.isSuccessHttpStatusCode ?? false)
    }
}
