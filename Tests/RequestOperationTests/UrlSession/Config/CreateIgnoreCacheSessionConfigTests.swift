//
//  CreateIgnoreCacheSessionConfigTests.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/30/25.
//

import Testing
@testable import RequestOperation
import Foundation

struct CreateIgnoreCacheSessionConfigTests {
    
    @Test
    func createIgnoreCacheSessionIgnoresTheCache() {
        
        let ignoreCacheSesion: URLSession = URLSession(configuration: CreateIgnoreCacheSessionConfig().createConfig())
        
        #expect(ignoreCacheSesion.configuration.requestCachePolicy == .reloadIgnoringLocalCacheData)
        #expect(ignoreCacheSesion.configuration.urlCache == nil)
        #expect(ignoreCacheSesion.configuration.httpShouldSetCookies == false)
        #expect(ignoreCacheSesion.configuration.httpCookieStorage == nil)
    }
    
    @Test
    func createIgnoreCacheSessionTimeoutIsCorrect() {
        
        let timeoutInterval: TimeInterval = 12
        
        let ignoreCacheSesion: URLSession = URLSession(
            configuration: CreateIgnoreCacheSessionConfig().createConfig(timeoutIntervalForRequest: timeoutInterval)
        )
        
        #expect(ignoreCacheSesion.configuration.timeoutIntervalForRequest == timeoutInterval)
    }
}
