//
//  Error+UrlRequestResponse.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 9/19/2023.
//  Copyright © 2023 Cru. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Will remove after transition to 1.6.0.")
extension Error {
    
    public func getRequestOperationUrlRequestResponse() -> UrlRequestResponse? {
        
        let userInfo: [String: Any] = (self as NSError).userInfo
        
        return userInfo[UrlRequestResponse.ServerErrorUserInfoKey.urlRequestResposne.rawValue] as? UrlRequestResponse
    }
    
    public func getRequestOperationUrlRequestResponseData() -> Data? {
                
        guard let responseData = getRequestOperationUrlRequestResponse()?.data else {
            return nil
        }
        
        return responseData
    }
    
    public func decodeRequestOperationUrlRequestResponseData<T: Decodable>() -> Result<T?, Error> {
        
        guard let data = getRequestOperationUrlRequestResponseData() else {
            return .failure(self)
        }
        
        do {
            let object: T = try JSONDecoder().decode(T.self, from: data)
            return .success(object)
        }
        catch let error {
            return .failure(error)
        }
    }
}
