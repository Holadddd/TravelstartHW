//
//  Bundel+Extension.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import Foundation

extension Bundle {
    
    static func TSValueForString(key: String) -> String {
        
        return Bundle.main.infoDictionary![key] as! String
    }

    static func TSValueForInt32(key: String) -> Int32 {

        return Bundle.main.infoDictionary![key] as! Int32
    }
}
