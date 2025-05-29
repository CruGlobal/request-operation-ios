//
//  RequestSenderTests+Decode.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation
import Combine

extension RequestSenderTests {
    
    func testSuccessfullyDecodeSuccessCodableWhenRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.englishLanguageId
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = Self.buildGetLanguageUrlRequest(urlSession: urlSession, languageId: languageId)

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .decodeRequestDataResponseForSuccessCodable()
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertNotNil(responseRef?.successCodable)
        XCTAssertTrue(responseRef?.successCodable?.dataObject.id == languageId)
    }
    
    func testSuccessCodableIsNilWhenRequestIsUnSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.invalidLanguageId
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = Self.buildGetLanguageUrlRequest(urlSession: urlSession, languageId: languageId)

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .decodeRequestDataResponseForSuccessCodable()
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertNil(responseRef?.successCodable)
    }
    
    func testSuccessfullyDecodeFailureCodableWhenRequestIsUnSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.invalidLanguageId
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = Self.buildGetLanguageUrlRequest(urlSession: urlSession, languageId: languageId)

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, MobileContentApiErrorsCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .decodeRequestDataResponseForSuccessOrFailureCodable()
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, MobileContentApiErrorsCodable>) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertNotNil(responseRef?.failureCodable)
    }
    
    func testReceiveDecodeErrorForSuccessCodableWhenRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.englishLanguageId
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = Self.buildGetLanguageUrlRequest(urlSession: urlSession, languageId: languageId)

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var decodeErrorRef: Error?
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<InvalidLanguageCodable>, NoResponseCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .decodeRequestDataResponseForSuccessCodable()
            .sink { completion in
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    decodeErrorRef = error
                }
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestCodableResponse<JsonApiResponseDataObject<InvalidLanguageCodable>, NoResponseCodable>) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNil(responseRef)
        XCTAssertNil(responseRef?.successCodable)
        XCTAssertNotNil(decodeErrorRef)
    }
    
    func testReceiveDecodeErrorForFailureCodableWhenRequestIsUnSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.invalidLanguageId
        
        let urlSession: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = Self.buildGetLanguageUrlRequest(urlSession: urlSession, languageId: languageId)

        let requestSender = RequestSender()
        
        let expectation = expectation(description: "")
        
        var decodeErrorRef: Error?
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, MobileContentApiErrorCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest, urlSession: urlSession)
            .decodeRequestDataResponseForSuccessOrFailureCodable()
            .sink { completion in
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    decodeErrorRef = error
                }
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, MobileContentApiErrorCodable>) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNil(responseRef)
        XCTAssertNil(responseRef?.failureCodable)
        XCTAssertNotNil(decodeErrorRef)
    }
}
