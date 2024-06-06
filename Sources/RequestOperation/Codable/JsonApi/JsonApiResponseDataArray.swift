//
//  JsonApiResponseDataArray.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 5/29/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

public struct JsonApiResponseDataArray<T: Codable>: Codable {
    
    public let dataArray: [T]
    
    public enum CodingKeys: String, CodingKey {
        case dataArray = "data"
    }
}
