//
//  JsonApiResponseBaseData.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct JsonApiResponseBaseData: Codable, Sendable {
    
    public let id: String
    public let type: String
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
    }
}
