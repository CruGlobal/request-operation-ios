//
//  TemplateTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class TemplateTests: XCTestCase {
    
    func testMethod() {
            
        let letterA: String = "a"
        let value: String = "a"
        
        XCTAssertTrue(value == letterA)
    }
}
