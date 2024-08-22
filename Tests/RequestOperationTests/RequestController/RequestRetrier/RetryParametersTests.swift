//
//  RetryParametersTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class RetryParametersTests: XCTestCase {
    
    func testDefaultParametersAreSet() {
        
        let retryParameters = RetryParameters()
        
        XCTAssertNil(retryParameters.delaySeconds)
    }
    
    func testDelaySecondsParameterIsSet() {
        
        let delaySeconds: TimeInterval = 5
        
        let retryParameters = RetryParameters(delaySeconds: delaySeconds)
        
        XCTAssertTrue(retryParameters.delaySeconds == delaySeconds)
    }
}
