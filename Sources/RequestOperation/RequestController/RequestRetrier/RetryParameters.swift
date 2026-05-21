//
//  RetryParameters.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/16/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct RetryParameters: Sendable {
    
    public let delaySeconds: TimeInterval?
    
    public init(delaySeconds: TimeInterval? = nil) {
        
        self.delaySeconds = delaySeconds
    }
}
