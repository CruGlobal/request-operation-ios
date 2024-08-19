//
//  RetryPolicy.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public enum RetryPolicy {
    
    case doNotRetry
    case retry(parameters: RetryParameters)
}
