//
//  UrlRequestResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 6/12/2023.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public class UrlRequestResponse {
    
    public let data: Data
    public let urlResponse: URLResponse
    
    init(data: Data, urlResponse: URLResponse) {
        
        self.data = data
        self.urlResponse = urlResponse
    }
    
    public func getDataUTF8String() -> String? {
        return String(data: data, encoding: .utf8)
    }
}
