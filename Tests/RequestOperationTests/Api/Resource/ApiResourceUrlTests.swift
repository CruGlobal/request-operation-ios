//
//  ApiResourceUrlTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class ApiResourceUrlTests: XCTestCase {
    
    func testPathIsCorrectUrlStructure() {
        
        let host: String = "my-url.com"
        let path: String = "my-path"
        
        let baseUrl = ApiBaseUrl(scheme: .https, host: host)
        
        let apiResourceUrl = ApiResourceUrl(baseUrl: baseUrl, path: path)
        
        XCTAssertTrue(apiResourceUrl.absoluteUrl == "https://\(host)/\(path)")
    }
}
