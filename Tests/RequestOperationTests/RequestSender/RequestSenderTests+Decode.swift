//
//  RequestSenderTests+Decode.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Testing
@testable import RequestOperation
import Foundation

extension RequestSenderTests {
    
    @Test()
    func successfullyDecodeSuccessCodableWhenRequestIsSuccessful() async throws {
        
        let requestSender = RequestSender()
        
        let languageId: String = englishLanguageId
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: languageId
        )
                
        let response: RequestCodableResponse<JsonApiResponseDataObject<LanguageCodable>, NoResponseCodable> = try await requestSender.sendDataTask(
            urlRequest: urlRequest,
            urlSession: urlSession
        ).decodeRequestDataResponseForSuccessCodable()
        
        let successCodable: JsonApiResponseDataObject<LanguageCodable> = try #require(response.successCodable)
        
        #expect(successCodable.dataObject.id == languageId)
    }
    
    @Test()
    func successCodableIsNilWhenRequestIsUnSuccessful() async throws {
        
        let requestSender = RequestSender()
        
        let languageId: String = invalidLanguageId
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: languageId
        )
                
        let response: RequestCodableResponse<JsonApiResponseDataObject<LanguageCodable>, NoResponseCodable> = try await requestSender.sendDataTask(
            urlRequest: urlRequest,
            urlSession: urlSession
        )
        .decodeRequestDataResponseForSuccessCodable()
                
        #expect(response.successCodable == nil)
    }
    
    @Test()
    func successfullyDecodeFailureCodableWhenRequestIsUnSuccessful() async throws {
        
        let requestSender = RequestSender()
        
        let languageId: String = invalidLanguageId
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: languageId
        )
                
        let response: RequestCodableResponse<JsonApiResponseDataObject<LanguageCodable>, MobileContentApiErrorsCodable> = try await requestSender.sendDataTask(
            urlRequest: urlRequest,
            urlSession: urlSession
        )
        .decodeRequestDataResponseForSuccessOrFailureCodable()
        
        #expect(response.failureCodable != nil)
    }
    
    @Test()
    func receiveDecodeErrorForSuccessCodableWhenRequestIsSuccessful() async throws {
        
        let requestSender = RequestSender()
        
        let languageId: String = englishLanguageId
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: languageId
        )
        
        let response: RequestCodableResponse<JsonApiResponseDataObject<InvalidLanguageCodable>, NoResponseCodable>?
        let decodeError: Error?
        
        do {
            
            response = try await requestSender.sendDataTask(
                urlRequest: urlRequest,
                urlSession: urlSession
            )
            .decodeRequestDataResponseForSuccessCodable()
            
            decodeError = nil
        }
        catch let error {
            
            response = nil
            decodeError = error
        }
        
        #expect(response == nil)
        #expect(decodeError != nil)
    }
    
    @Test()
    func receiveDecodeErrorForFailureCodableWhenRequestIsUnSuccessful() async throws {
        
        let requestSender = RequestSender()
        
        let languageId: String = invalidLanguageId
        
        let urlRequest: URLRequest = try getLanguageUrlRequest(
            languageId: languageId
        )
                        
        let response: RequestCodableResponse<JsonApiResponseDataObject<LanguageCodable>, MobileContentApiErrorCodable>?
        let decodeError: Error?
        
        do {
            
            response = try await requestSender.sendDataTask(
                urlRequest: urlRequest,
                urlSession: urlSession
            )
            .decodeRequestDataResponseForSuccessOrFailureCodable()
            
            decodeError = nil
        }
        catch let error {
            
            response = nil
            decodeError = error
        }
        
        #expect(response == nil)
        #expect(decodeError != nil)
    }
}
