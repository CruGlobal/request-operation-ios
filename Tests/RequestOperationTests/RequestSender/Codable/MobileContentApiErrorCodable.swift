//
//  MobileContentApiErrorCodable.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/13/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

struct MobileContentApiErrorCodable: Codable, Sendable {
    
    let detail: String
    
    enum RootKeys: String, CodingKey {
        case detail = "detail"
    }
}
