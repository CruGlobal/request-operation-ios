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
}
