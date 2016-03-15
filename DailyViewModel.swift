//
//  DailyViewModel.swift
//  WeatherApp
//

//  Created by Jun Dang on 16/2/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation

struct DailyViewModel {
  
    let day: String
    let dailyIconName: String
    let dailyTemperatureHigh: String
    let dailyTemperatureLow: String
    
    init(_ dailyForecast: DailyForecast) {
        day = dailyForecast.day
        dailyIconName = dailyForecast.dailyIconName
        dailyTemperatureHigh = dailyForecast.dailyTemperatureHigh
        dailyTemperatureLow = dailyForecast.dailyTemperatureLow
        
    }
    
}