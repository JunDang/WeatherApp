//
//  HourlyViewModel.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/23.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation

struct HourlyViewModel {
 
    let time: String
    let iconName: String
    let temperature: String
    
    init(_ hourlyForecast: HourlyForecast) {
        time = hourlyForecast.time
        iconName = hourlyForecast.iconName
        temperature = hourlyForecast.temperature
    }
    
}