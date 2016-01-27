//
//  WeatherBuilder.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/7.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation

struct WeatherBuilder {
    var location: String?
    var currentIconName: String?
    var currentTemperature: String?
    var currentTemperatureHigh: String?
    var currentTemperatureLow: String?
    
    var hourlyForecasts: [HourlyForecast]?
    var dailyForecasts: [DailyForecast]?
    
    //create an istance of Weather, similar to constructor
    func build() -> Weather {
        return Weather(location: location!,
            currentIconName: currentIconName!,
            currentTemperature: currentTemperature!,
            currentTemperatureHigh: currentTemperatureHigh!,
            currentTemperatureLow: currentTemperatureLow!,
            hourlyForecasts: hourlyForecasts!,
            dailyForecasts: dailyForecasts!)
    }

}


