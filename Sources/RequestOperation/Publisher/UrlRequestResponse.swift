//
//  UrlRequestResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 6/12/2023.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public class UrlRequestResponse {
    
    public enum ServerErrorUserInfoKey: String {
        case httpStatusCode = "UrlRequestResponse.httpStatusCode.userInfoKey"
        case urlRequestResposne = "UrlRequestResponse.urlRequestResponse.userInfoKey"
    }
        
    public let data: Data
    public let urlResponse: URLResponse
    
    init(data: Data, urlResponse: URLResponse) {
        
        self.data = data
        self.urlResponse = urlResponse
    }
    
    public func getDataUTF8String() -> String? {
        return String(data: data, encoding: .utf8)
    }
    
    public func getServerError() -> Error? {
        
        guard !urlResponse.isSuccessHttpStatusCode else {
            return nil
        }
        
        let httpStatusCode: Int = urlResponse.httpStatusCode ?? -1
        let errorMessage: String = "UrlRequest failed. Server responded with http status code: \(httpStatusCode)"
            
        return NSError(
            domain: "Server Error",
            code: httpStatusCode,
            userInfo: [
                NSLocalizedDescriptionKey: errorMessage,
                ServerErrorUserInfoKey.httpStatusCode.rawValue: httpStatusCode,
                ServerErrorUserInfoKey.urlRequestResposne.rawValue: self
            ]
        )
    }
}
