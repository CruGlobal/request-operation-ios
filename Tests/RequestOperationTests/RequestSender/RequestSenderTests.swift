//
//  RequestSenderTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/13/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import XCTest
@testable import RequestOperation
import Combine

class RequestSenderTests: XCTestCase {
 
    private static let languagesUrl: String = "https://mobile-content-api-stage.cru.org/languages"
    private static let englishLanguageId: String = "4"
    private static let invalidLanguageId: String = "-37469355108471600907768582811183"
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    private func buildGetLanguageUrlRequest(session: URLSession, languageId: String) -> URLRequest {
        
        let requestBuilder = RequestBuilder()
        
        let urlString: String = Self.languagesUrl + "/" + languageId
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: session,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: nil
            )
        )
        
        return urlRequest
    }
    
    func testSendUrlRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
                
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: Self.englishLanguageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestDataResponse?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertTrue(responseRef!.urlResponse.isSuccessHttpStatusCode)
    }
    
    func testSendUrlRequestIsUnSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: Self.invalidLanguageId)
        
        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestDataResponse?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
            .sink { completion in
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
                responseRef = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(responseRef)
        XCTAssertFalse(responseRef!.urlResponse.isSuccessHttpStatusCode)
    }
    
    func testSendUrlRequestFailedWithUrlError() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let requestBuilder = RequestBuilder()
        
        let urlWithBadHost: String = "https://37469355108471600907768582811183.com/languages/4"
        let urlString: String = urlWithBadHost
        let requestMethod: RequestMethod = .get
        let contentType: String = "application/vnd.api+json"
        
        let urlRequest: URLRequest = requestBuilder.build(
            parameters: RequestBuilderParameters(
                urlSession: session,
                urlString: urlString,
                method: requestMethod,
                headers: ["Content-Type": contentType],
                httpBody: nil,
                queryItems: nil
            )
        )

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var errorRef: Error?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
            .sink { completion in
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    errorRef = error
                }
                
                expectation.fulfill()
                
            } receiveValue: { (response: RequestDataResponse) in
                
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeoutSeconds)
        
        XCTAssertNotNil(errorRef)
        XCTAssertNotNil(errorRef?.getUrlError())
        XCTAssertTrue(errorRef!.isUrlError)
        XCTAssertTrue((errorRef as? NSError)?.domain == URLError.toErrorDomain)
    }
    
    func testSuccessfullyDecodeSuccessCodableWhenRequestIsSuccessful() {
        
        let timeoutSeconds: TimeInterval = 15
        
        let languageId: String = Self.englishLanguageId
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
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
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, NoResponseCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
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
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, MobileContentApiErrorsCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
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
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var decodeErrorRef: Error?
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<InvalidLanguageCodable>, NoResponseCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
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
        
        let session: URLSession = RequestUrlSession.createIgnoreCacheSession(timeoutIntervalForRequest: timeoutSeconds)
        
        let urlRequest: URLRequest = buildGetLanguageUrlRequest(session: session, languageId: languageId)

        let requestSender = RequestSender(session: session)
        
        let expectation = expectation(description: "")
        
        var decodeErrorRef: Error?
        var responseRef: RequestCodableResponse<JsonApiResponseDataObject<LanguageModel>, MobileContentApiErrorCodable>?
        
        requestSender.sendDataTaskPublisher(urlRequest: urlRequest)
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
