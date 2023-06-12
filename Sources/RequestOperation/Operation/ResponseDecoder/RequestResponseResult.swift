//
//  RequestResponseResult.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

public enum RequestResponseResult<HttpClientSuccessResponseType: Decodable, HttpClientErrorResponseType: Decodable> {
    
    case success(response: HttpClientSuccessResponseType?, responseDecodeError: Error?)
    case failure(responseError: RequestResponseError<HttpClientErrorResponseType>)
}
