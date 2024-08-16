//
//  RequestOperationTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation

class RequestUrlSessionTests: XCTestCase {
    
    func testCreateIgnoreCacheSessionIgnoresTheCache() {
        
        let ignoreCacheSesion: URLSession = RequestUrlSession.createIgnoreCacheSession()
        
        XCTAssertTrue(ignoreCacheSesion.configuration.requestCachePolicy == .reloadIgnoringLocalCacheData, "requestCachePolicy should equal reloadIgnoringLocalCacheData")
        XCTAssertNil(ignoreCacheSesion.configuration.urlCache, "urlCache should be nil")
        
        XCTAssertTrue(ignoreCacheSesion.configuration.httpShouldSetCookies == false, "httpShouldSetCookies should be false")
        XCTAssertNil(ignoreCacheSesion.configuration.httpCookieStorage, "httpCookieStorage should be nil")
    }
    
    func testCreateIgnoreCacheSessionTimeoutIsCorrect() {
        
        let timeoutInterval: TimeInterval = 12
        
        let ignoreCacheSesion: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutInterval)
        
        XCTAssertTrue(ignoreCacheSesion.configuration.timeoutIntervalForRequest == timeoutInterval)
    }
}
