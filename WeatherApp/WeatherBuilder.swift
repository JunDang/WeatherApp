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
    var feelsLikeTemperature: String?
    var currentSummary: String?
    var dailySummary: String?
    var minutelySummary: String?
    
    var precipitationProbability: String?
    var precipitationType: String?
    var precipitationIntensity: String?
    var dewPoint: String?
    var humidity: String?
    var windDirection: String?
    var windSpeed: String?
    var sunriseTime: String?
    var sunsetTime: String?
    var cloudCover: String?
    
    var hourlyForecasts: [HourlyForecast]?
    var dailyForecasts: [DailyForecast]?
    
    //create an istance of Weather, similar to constructor
    func build() -> Weather {
        return Weather(location: location!,
            currentIconName: currentIconName!,
            currentTemperature: currentTemperature!,
            currentTemperatureHigh: currentTemperatureHigh!,
            currentTemperatureLow: currentTemperatureLow!,
            feelsLikeTemperature: feelsLikeTemperature!,
            currentSummary: currentSummary!,
            dailySummary: dailySummary!,
            minutelySummary: minutelySummary!,
            precipitationProbability:precipitationProbability!,
            precipitationType: precipitationType!,
            precipitationIntensity: precipitationIntensity!,
            dewPoint: dewPoint!,
            humidity: humidity!,
            windDirection: windDirection!,
            windSpeed: windSpeed!,
            sunriseTime: sunriseTime!,
            sunsetTime: sunsetTime!,
            cloudCover: cloudCover!,
            hourlyForecasts: hourlyForecasts!,
            dailyForecasts: dailyForecasts!)
    }

}


