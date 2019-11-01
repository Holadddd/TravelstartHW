//
//  JSONObject.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import Foundation

struct TaipeiOpenAPIData: Codable {
    
    var result: DataResult
    
    enum CodingKeys: String, CodingKey {
        case result
    }
}
//I dont write Result to prevent ambiguous name with Result(enum)
struct DataResult: Codable {
    
    var limit: Int
    
    var offset: Int
    
    var count: Int
    
    var sort: String
    
    var results: [ResultInfo]
    
    enum CodingKeys: String, CodingKey {
        case limit, offset, count, sort, results
    }
}

struct ResultInfo: Codable  {
    var info: String
    
    var stitle: String
    
    var xpostDate: String
    
    var langinfo: String
    
    var mrt: String
    
    var serialNumber: String
    
    var rowNumber: String
    
    var category_Type: String
    
    var category_Style: String
    
    var businessHours: String
    
    var poi: String
    
    var file: String
    
    var idpt: String
    
    var latitude: String
    
    var description: String
    
    var id: Int
    
    var avEnd: String
    
    var address: String
    
    enum CodingKeys: String, CodingKey {
        case info, stitle, xpostDate, langinfo
        
        case mrt = "MRT"
        
        case serialNumber = "SERIAL_NO"
        
        case rowNumber = "RowNumber"
        
        case category_Type = "CAT1"
        
        case category_Style = "CAT2"
        
        case businessHours = "MEMO_TIME"
        
        case poi = "POI"
        
        case file, idpt, latitude
        
        case description = "xbody"
        
        case id = "_id"
        
        case avEnd, address
    }
}
