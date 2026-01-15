//
//  JsonApiFilterTests.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/12/2026.
//  Copyright © 2026 Cru. All rights reserved.
//

import Foundation
import Testing
@testable import RequestOperation

struct JsonApiFilterTests {
        
    @Test()
    func createFilter() async {
        
        let filter = JsonApiFilter(name: "name", values: ["value_1", "value_2"])
        
        #expect(filter.name == "name")
        #expect(filter.values == ["value_1", "value_2"])
        
        #expect(filter.queryName == "filter[name]")
        #expect(filter.queryValue == "value_1,value_2")
        
        let urlQueryItem: URLQueryItem = filter.toUrlQueryItem()
        
        #expect(urlQueryItem.name == "filter[name]")
        #expect(urlQueryItem.value == "value_1,value_2")
    }
    
    @Test()
    func buildQueryItems() async throws {
        
        let builtUrlQueryItems: [URLQueryItem]? = JsonApiFilter.buildQueryItems(
            nameValues: [
                "name_1": ["value_1", "value_2"],
                "name_2": ["value_a", "value_b", nil, "value_c"]
            ]
        )
        
        let urlQueryItems: [URLQueryItem] = try #require(builtUrlQueryItems)
        
        #expect(urlQueryItems.count == 2)
        
        let name1: URLQueryItem = try #require(urlQueryItems.first(where: { $0.name == "filter[name_1]" }))
        let name2: URLQueryItem = try #require(urlQueryItems.first(where: { $0.name == "filter[name_2]" }))
        
        #expect(name1.value == "value_1,value_2")
        #expect(name2.value == "value_a,value_b,value_c")
    }
}
