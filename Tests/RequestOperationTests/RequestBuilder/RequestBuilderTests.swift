//
//  RequestBuilderTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class RequestBuilderTests: XCTestCase {
    
 
    func testDefaultParametersAreSet() {
        
        let requestBuilder = RequestBuilder()
        
        XCTAssertTrue(requestBuilder.requestMutators.isEmpty)
    }
    
    func testCloneWithoutMutators() {
        
        let requestBuilderWithoutMutators = RequestBuilder(requestMutators: [])
        
        XCTAssertTrue(requestBuilderWithoutMutators == requestBuilderWithoutMutators.clone())
    }
    
    func testCloneWithMutators() {
        
        let requestBuilderWithMutators = RequestBuilder(requestMutators: [TestRequestMutatorA(), TestRequestMutatorB()])
        
        XCTAssertTrue(requestBuilderWithMutators == requestBuilderWithMutators.clone())
    }
    
    func testRequestBuilderMutatorsAreEqual() {
        
        let requestBuilderA = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        let requestBuilderB = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        
        XCTAssertTrue(requestBuilderA == requestBuilderB)
    }
    
    func testRequestBuilderMutatorsAreNotEqual() {
        
        let requestBuilderA = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        let requestBuilderB = RequestBuilder(requestMutators: [TestRequestMutatorB()])
        
        XCTAssertTrue(requestBuilderA != requestBuilderB)
    }
    
    func testBuildUrlRequest() {
        
        let requestBuilder = RequestBuilder()
        
        let urlString: String = "https://mobile-content-api-stage.cru.org/languages/4"
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                requestCachePolicy: .reloadIgnoringCacheData,
                timeoutIntervalForRequest: 60,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: nil
            )
        )
                
        XCTAssertTrue(urlRequest.url?.absoluteString == urlString)
        XCTAssertTrue(urlRequest.httpMethod == requestMethod.rawValue)
        XCTAssertTrue(urlRequest.allHTTPHeaderFields?["Content-Type"] == contentType)
    }
}
