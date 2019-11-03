//
//  UserRequest.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import Foundation
//Able to expand different api
enum TSUserRequest: TSRequest {
    
    case taipeiOpenAPI(offset: Int, limit: Int)
    
    var headers: [String : String] {
        switch self {
        case .taipeiOpenAPI:
            return [:]
      
        }
    }
    
    var body: Data? {
        switch self {
        case .taipeiOpenAPI:
            return nil
        }
    }
    
    var method: String {
        
        switch self {
            
        case .taipeiOpenAPI:
            return TSHTTPMethod.GET.rawValue
        
        }
    }
    
    var endPoint: String {
        
        switch self {
        case .taipeiOpenAPI(let offset,let limit):
            return "?scope=resourceAquire&rid=36847f3f-deff-4183-a5bb-800737591de5&offset=\(offset)&limit=\(limit)"
        }
    }
    
}



