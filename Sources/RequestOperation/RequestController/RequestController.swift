//
//  RequestController.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public final class RequestController: Sendable {
    
    public let requestBuilder: RequestBuilder
    public let requestSender: RequestSender
    public let requestRetrier: RequestRetrier?
    
    public init(requestBuilder: RequestBuilder, requestSender: RequestSender, requestRetrier: RequestRetrier? = nil) {
        
        self.requestBuilder = requestBuilder
        self.requestSender = requestSender
        self.requestRetrier = requestRetrier
    }
    
    public func buildAndSendRequest<SuccessCodable: Codable, FailureCodable: Codable>(
        urlSession: URLSession,
        urlString: String,
        method: RequestMethod,
        headers: [String: String]?,
        httpBody: [String: Any]?,
        queryItems: [URLQueryItem]?,
        timeoutIntervalForRequest: TimeInterval? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> RequestCodableResponse<SuccessCodable, FailureCodable> {
        
        return try await internalBuildAndSendRequest(
            urlSession: urlSession,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: timeoutIntervalForRequest
        )
        .decodeRequestDataResponseForSuccessOrFailureCodable(decoder: decoder)
    }
    
    private func internalBuildAndSendRequest(
        urlSession: URLSession,
        urlString: String,
        method: RequestMethod,
        headers: [String: String]?,
        httpBody: [String: Any]?,
        queryItems: [URLQueryItem]?,
        timeoutIntervalForRequest: TimeInterval?
    ) async throws -> RequestDataResponse {
        
        let urlRequest: URLRequest = try requestBuilder.build(
            parameters: try RequestBuilderParameters(
                urlSession: urlSession,
                urlString: urlString,
                method: method,
                headers: headers,
                httpBody: httpBody,
                queryItems: queryItems,
                timeoutIntervalForRequest: timeoutIntervalForRequest
            )
        )
        
        let response = try await requestSender
            .sendDataTask(
                urlRequest: urlRequest,
                urlSession: urlSession
            )
        
        return try await retryRequestIfNeeded(
            response: response,
            urlSession: urlSession,
            urlString: urlString,
            method: method,
            headers: headers,
            httpBody: httpBody,
            queryItems: queryItems,
            timeoutIntervalForRequest: timeoutIntervalForRequest
        )
    }
    
    private func retryRequestIfNeeded(
        response: RequestDataResponse,
        urlSession: URLSession,
        urlString: String,
        method: RequestMethod,
        headers: [String: String]?,
        httpBody: [String: Any]?,
        queryItems: [URLQueryItem]?,
        timeoutIntervalForRequest: TimeInterval?
    ) async throws -> RequestDataResponse {
        
        guard let requestRetrier = self.requestRetrier else {
            return response
        }
        
        let retryPolicy: RetryPolicy = requestRetrier.shouldRetryRequest(
            response: response,
            httpStatusCode: response.urlResponse.httpStatusCode,
            isSuccessHttpStatusCode: response.urlResponse.isSuccessHttpStatusCode
        )
        
        switch retryPolicy {
       
        case .doNotRetry:
            return response
            
        case .retry( _):
            return try await internalBuildAndSendRequest(
                urlSession: urlSession,
                urlString: urlString,
                method: method,
                headers: headers,
                httpBody: httpBody,
                queryItems: queryItems,
                timeoutIntervalForRequest: timeoutIntervalForRequest
            )
        }
    }
}
