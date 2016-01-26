//
//  Temperature.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/6.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation

struct Temperature {
    let degrees: String
    
   /* init(country: String, forecastIoDegrees: Double) {
        if country == "US" {
            degrees = String(round(((forecastIoDegrees - 273.15) * 1.8) + 32)) + "\u{00B0}"
        } else {
            degrees = String(round(forecastIoDegrees - 273.15)) + "\u{00B0}"
        }
        
    }*/
    init(forecastIoDegrees: Double) {
        degrees = String(round((forecastIoDegrees - 32) / 1.8)) + "\u{00B0}"
    }
    
}
