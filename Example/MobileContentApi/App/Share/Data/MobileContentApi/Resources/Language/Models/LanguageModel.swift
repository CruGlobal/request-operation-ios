//
//  LanguageModel.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 8/6/24.
//

import Foundation

struct LanguageModel: Codable {
    
    let code: String
    let direction: String
    let id: String
    let name: String
    let type: String
    
    enum RootKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }
    
    enum AttributesKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case direction = "direction"
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
        direction = try attributesContainer?.decodeIfPresent(String.self, forKey: .direction) ?? ""
        name = try attributesContainer?.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

extension LanguageModel: Equatable {
    static func ==(lhs: LanguageModel, rhs: LanguageModel) -> Bool {
        return lhs.id == rhs.id
    }
}

