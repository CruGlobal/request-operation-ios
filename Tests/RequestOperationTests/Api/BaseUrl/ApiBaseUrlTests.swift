//
//  RequestOperationTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class ApiBaseUrlTests: XCTestCase {

    private let mobileContentApiHost: String = "mobile-content-api.cru.org"
    
    func testSchemeIsHttps() {
        
        let baseUrl = ApiBaseUrl(scheme: .https, host: mobileContentApiHost)
        
        XCTAssertTrue(baseUrl.absoluteUrl.contains("https://"))
    }
    
    func testAbsoluteUrl() {
        
        let baseUrl = ApiBaseUrl(scheme: .https, host: mobileContentApiHost)
        
        XCTAssertTrue(baseUrl.absoluteUrl == "https://mobile-content-api.cru.org")
    }
    
    func testUrl() {
        
        let baseUrl = ApiBaseUrl(scheme: .https, host: mobileContentApiHost)
        
        XCTAssertTrue(baseUrl.url?.absoluteString == "https://mobile-content-api.cru.org")
    }
}
