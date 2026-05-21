//
//  RequestBuilderTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/22/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Testing
@testable import RequestOperation
import Foundation

struct RequestBuilderTests {
    
    @Test func defaultParametersAreSet() async {
        
        let requestBuilder = RequestBuilder()
        
        #expect(requestBuilder.requestMutators.isEmpty)
    }
    
    @Test func initWithRequestBuilderFallsBackToRequestBuilderRequestMutators() async {
        
        let requestBuilderA = RequestBuilder(requestMutators: [TestRequestMutatorA(), TestRequestMutatorB()])
        
        let requestBuilderB = RequestBuilder(requestBuilder: requestBuilderA, requestMutators: nil)
        
        #expect(requestBuilderA == requestBuilderB)
    }
    
    @Test func cloneWithoutMutators() async {
        
        let requestBuilderWithoutMutators = RequestBuilder(requestMutators: [])
        
        #expect(requestBuilderWithoutMutators == requestBuilderWithoutMutators.clone())
    }
    
    @Test func cloneWithMutators() async {
        
        let requestBuilderWithMutators = RequestBuilder(requestMutators: [TestRequestMutatorA(), TestRequestMutatorB()])
        
        #expect(requestBuilderWithMutators == requestBuilderWithMutators.clone())
    }
    
    @Test func requestBuilderMutatorsAreEqual() async {
        
        let requestBuilderA = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        let requestBuilderB = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        
        #expect(requestBuilderA == requestBuilderB)
    }
    
    @Test func requestBuilderMutatorsAreNotEqual() async {
        
        let requestBuilderA = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        let requestBuilderB = RequestBuilder(requestMutators: [TestRequestMutatorB()])
        
        #expect(requestBuilderA != requestBuilderB)
    }
    
    @Test func requestBuilderMutatorsCountIsNotEqual() async {
        
        let requestBuilderA = RequestBuilder(requestMutators: [TestRequestMutatorA()])
        let requestBuilderB = RequestBuilder(requestMutators: [TestRequestMutatorA(), TestRequestMutatorB()])
        
        #expect(requestBuilderA != requestBuilderB)
    }
    
    @Test func buildUrlRequestFromString() async throws {
        
        let requestBuilder = RequestBuilder()
        
        let urlString: String = "https://mobile-content-api-stage.cru.org/languages/4"
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        let httpBody: [String: Any] = ["key_1": 1, "key_2": "2", "key_3": 3.0, "key_4": false]
        
        let urlRequest: URLRequest = try requestBuilder.build(
            parameters: RequestBuilderParameters(
                requestCachePolicy: .reloadIgnoringCacheData,
                timeoutIntervalForRequest: 60,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: httpBody,
                queryItems: nil
            )
        )
        
        let urlRequestHttpBodyData: Data = try #require(urlRequest.httpBody)
        
        let urlRequestHttpBody: [String: Any] = try JSONSerialization.jsonObject(with: urlRequestHttpBodyData, options: []) as? [String: Any] ?? Dictionary()
        
        #expect(urlRequest.url?.absoluteString == urlString)
        #expect(urlRequest.httpMethod == requestMethod.rawValue)
        #expect(urlRequest.allHTTPHeaderFields?["Content-Type"] == contentType)
        #expect(urlRequestHttpBody.count == httpBody.count)
        #expect(Array(urlRequestHttpBody.keys).sorted() == Array(httpBody.keys).sorted())
    }
    
    @Test func buildUrlRequestFromStringWithUrlQuery() async throws {
        
        let requestBuilder = RequestBuilder(
            requestMutators: [TestRequestMutatorA()]
        )
        
        let urlString: String = "https://mobile-content-api-stage.cru.org/languages/4"
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "param_1", value: "1")
        ]
        
        let urlRequest: URLRequest = try requestBuilder.build(
            parameters: RequestBuilderParameters(
                requestCachePolicy: .reloadIgnoringCacheData,
                timeoutIntervalForRequest: 60,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: queryItems
            )
        )
        
        let urlStringWithQuery: String = "https://mobile-content-api-stage.cru.org/languages/4" + "?param_1=1"
        
        #expect(urlRequest.url?.absoluteString == urlStringWithQuery)
        #expect(urlRequest.httpMethod == requestMethod.rawValue)
        #expect(urlRequest.allHTTPHeaderFields?["Content-Type"] == contentType)
    }
}
