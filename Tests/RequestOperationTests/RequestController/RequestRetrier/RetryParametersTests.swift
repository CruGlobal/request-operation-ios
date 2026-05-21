//
//  RetryParametersTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Testing
@testable import RequestOperation
import Foundation

struct RetryParametersTests {
    
    @Test
    func defaultParametersAreSet() {
        
        let retryParameters = RetryParameters()
        
        #expect(retryParameters.delaySeconds == nil)
    }
    
    @Test
    func delaySecondsParameterIsSet() {
        
        let delaySeconds: TimeInterval = 5
        
        let retryParameters = RetryParameters(delaySeconds: delaySeconds)
        
        #expect(retryParameters.delaySeconds == delaySeconds)
    }
}
