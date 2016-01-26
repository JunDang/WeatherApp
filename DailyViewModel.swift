//
//  DailyViewModel.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/17.
//  Copyright © 2016年 Jun Jun. All rights reserved.
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