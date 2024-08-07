//
//  RequestCodableResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct RequestCodableResponse<T: Codable> {
    
    public let codable: T?
    public let requestDataResponse: RequestDataResponse
    
    public init(codable: T?, requestDataResponse: RequestDataResponse) {
    
        self.codable = codable
        self.requestDataResponse = requestDataResponse
    }
}
