//
//  MobileContentApiErrorsCodable.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/13/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

struct MobileContentApiErrorsCodable: Codable {
    
    let errors: [MobileContentApiErrorCodable]
    
    enum RootKeys: String, CodingKey {
        case errors = "errors"
    }
}
