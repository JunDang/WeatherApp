//
//  Weather.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/6.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation

struct Weather {
    let location: String
    let currentIconName: String
    let currentTemperature: String
    let currentTemperatureHigh: String
    let currentTemperatureLow: String
   
    
    let hourlyForecasts: [HourlyForecast]
    let dailyForecasts: [DailyForecast]
}
