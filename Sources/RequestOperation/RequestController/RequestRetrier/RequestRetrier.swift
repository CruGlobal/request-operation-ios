//
//  RequestRetrier.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

public protocol RequestRetrier {
    
    func shouldRetryRequestPublisher(response: RequestDataResponse, httpStatusCode: Int?, isSuccessHttpStatusCode: Bool) -> AnyPublisher<RetryPolicy, Never>
}
