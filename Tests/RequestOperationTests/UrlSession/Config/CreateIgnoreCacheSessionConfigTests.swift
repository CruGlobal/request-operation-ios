//
//  CreateIgnoreCacheSessionConfigTests.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/30/25.
//

import XCTest
@testable import RequestOperation

class CreateIgnoreCacheSessionConfigTests: XCTestCase {
    
    func testCreateIgnoreCacheSessionIgnoresTheCache() {
        
        let ignoreCacheSesion: URLSession = URLSession(configuration: CreateIgnoreCacheSessionConfig().createConfig())
        
        XCTAssertTrue(ignoreCacheSesion.configuration.requestCachePolicy == .reloadIgnoringLocalCacheData, "requestCachePolicy should equal reloadIgnoringLocalCacheData")
        XCTAssertNil(ignoreCacheSesion.configuration.urlCache, "urlCache should be nil")
        
        XCTAssertTrue(ignoreCacheSesion.configuration.httpShouldSetCookies == false, "httpShouldSetCookies should be false")
        XCTAssertNil(ignoreCacheSesion.configuration.httpCookieStorage, "httpCookieStorage should be nil")
    }
    
    func testCreateIgnoreCacheSessionTimeoutIsCorrect() {
        
        let timeoutInterval: TimeInterval = 12
        
        let ignoreCacheSesion: URLSession = URLSession(
            configuration: CreateIgnoreCacheSessionConfig().createConfig(timeoutIntervalForRequest: timeoutInterval)
        )
        
        XCTAssertTrue(ignoreCacheSesion.configuration.timeoutIntervalForRequest == timeoutInterval)
    }
}
