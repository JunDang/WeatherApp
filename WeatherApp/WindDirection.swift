//
//  WindDirection.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/2/11.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation

struct WindDirection {
    
    var windDirection: String?
 
    
    
    init(windBearing: Double){
        
        var directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
            "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        
        let i:Int = Int((windBearing + 11.25)/22.5)
        
        windDirection = String(directions[i % 16])
       
    
    }
    
    

    
    
    
    
    
    
    
}