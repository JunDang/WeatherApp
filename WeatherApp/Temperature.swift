//
//  Temperature.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation

struct Temperature {
    let degrees: String
    
    init(forecastIoDegrees: Double) {
        degrees = String(Int(round((forecastIoDegrees - 32) / 1.8))) + "\u{00B0}"
    }
    
    
}
