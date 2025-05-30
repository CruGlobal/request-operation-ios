//
//  CreateUrlSessionConfigInterface.swift
//  RequestOperation
//
//  Created by Levi Eggert on 5/30/25.
//

import Foundation

public protocol CreateUrlSessionConfigInterface {
    
    func createConfig(timeoutIntervalForRequest: TimeInterval) -> URLSessionConfiguration
}
