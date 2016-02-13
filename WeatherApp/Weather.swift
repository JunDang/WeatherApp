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
    let feelsLikeTemperature: String
    
    let currentSummary: String
    let dailySummary: String
    let minutelySummary: String
    
    let precipitationProbability: String
    let precipitationIntensity: String
    let precipitationType: String
    let dewPoint: String
    let humidity: String
    let windDirection: String
    let windSpeed: String
    let sunriseTime: String
    let sunsetTime: String
    let cloudCover: String
    
    //let weeklySummary: String

   
    
    let hourlyForecasts: [HourlyForecast]
    let dailyForecasts: [DailyForecast]
}
