//
//  Error.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation

struct Error {
    enum Code: Int {
        case URLError                 = -6000
        case NetworkRequestFailed     = -6001
        case JSONSerializationFailed  = -6002
        case JSONParsingFailed        = -6003
    }
    
    let errorCode: Code

}
