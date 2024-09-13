//
//  InvalidLanguageCodable.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/13/2024.
//  Copyright © 2024 Cru. All rights reserved.
//

import Foundation

struct InvalidLanguageCodable: Codable {
    
    let code: String
    let id: String
    let name: String
    let type: String
    
    enum RootKeys: String, CodingKey {
        case id = "invalid_id"
        case type = "type"
        case attributes = "attributes"
    }
    
    enum AttributesKeys: String, CodingKey {
        case code = "code"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        
        var attributesContainer: KeyedDecodingContainer<AttributesKeys>?

        do {
            attributesContainer = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
        }
        catch  {
            // It's possible that a Language doesn't have an attributes key.
        }
        
        // attributes
        code = try attributesContainer?.decodeIfPresent(String.self, forKey: .code) ?? ""
        name = try attributesContainer?.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
