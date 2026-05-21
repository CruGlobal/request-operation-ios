//
//  RequestRetrier.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public protocol RequestRetrier: Sendable {
    
    func shouldRetryRequest(response: RequestDataResponse, httpStatusCode: Int?, isSuccessHttpStatusCode: Bool) -> RetryPolicy
}
