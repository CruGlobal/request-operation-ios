//
//  JsonApiFilter.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/12/2026.
//  Copyright © 2026 Cru. All rights reserved.
//

import Foundation

public struct JsonApiFilter {
    
    public let name: String
    public let values: [String]
    
    public init(name: String, values: [String]) {
        
        self.name = name
        self.values = values
    }
    
    public var queryName: String {
        return "filter[\(name)]"
    }
    
    public var queryValue: String {
        return values.joined(separator: ",")
    }
}

extension JsonApiFilter {
    
    public func toUrlQueryItem() -> URLQueryItem {
        return URLQueryItem(name: queryName, value: queryValue)
    }
    
    public func buildQueryItems(nameValues: [String: [String?]]) -> [URLQueryItem]? {
        
        var queryItems: [URLQueryItem] = Array()
        
        for (name, values) in nameValues {
            
            queryItems.append(
                JsonApiFilter(
                    name: name,
                    values: values.compactMap { $0 }
                ).toUrlQueryItem()
            )
        }
        
        guard queryItems.count > 0 else {
            return nil
        }
        
        return queryItems
    }
}
