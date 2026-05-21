//
//  JsonApiResponseDataObject.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct JsonApiResponseDataObject<T: Codable & Sendable>: Codable, Sendable {
    
    public let dataObject: T
    
    public enum CodingKeys: String, CodingKey {
        case dataObject = "data"
    }
}
