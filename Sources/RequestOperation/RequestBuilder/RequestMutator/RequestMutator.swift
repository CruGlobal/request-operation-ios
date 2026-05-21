//
//  RequestMutator.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 8/12/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public protocol RequestMutator: Sendable {
    
    func mutate(request: inout URLRequest, parameters: RequestBuilderParameters)
}
