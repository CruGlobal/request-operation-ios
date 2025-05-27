//
//  Publisher+Validate.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/17/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation
import Combine

extension Publisher where Output == RequestDataResponse, Failure == Error {
    
    public func validate(successRange: Range<Int> = URLResponse.httpStatusCodeSuccessRange) -> AnyPublisher<RequestDataResponse, Error> {
        
        self.tryMap { (response: RequestDataResponse) in
            
            return try response.validate()
        }
        .eraseToAnyPublisher()
    }
}
