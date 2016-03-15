//
//  WeatherAirQualityBuilder.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/3/14.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation

struct WeatherAirQualityBuilder {
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
    var precipitationIntensity: String?
    //var precipitationType: String?
    var dewPoint: String?
    var humidity: String?
    //var windDirection: String?
    var windSpeed: String?
    var sunriseTime: String?
    var sunsetTime: String?
    var cloudCover: String?
    //var weeklySummary: String?
    var hourlyForecasts: [HourlyForecast]?
    var dailyForecasts: [DailyForecast]?
    //air quality
    var airQualityDescription: String?
    var dominantPollutantDescription: String?
    var recommendationsChildren: String?
    var recommendationsHealth: String?
    var recommendationsInside: String?
    var recommendationsOutside: String?
    var recommendationsSport: String?

    //create an istance of WeatherAirQuality, similar to constructor
    func buildData() -> WeatherAirQuality {
        return WeatherAirQuality(location: location!,
            currentIconName: currentIconName!,
            currentTemperature: currentTemperature!,
            currentTemperatureHigh: currentTemperatureHigh!,
            currentTemperatureLow: currentTemperatureLow!,
            feelsLikeTemperature: feelsLikeTemperature!,
            currentSummary: currentSummary!,
            dailySummary: dailySummary!,
            minutelySummary: minutelySummary!,
            precipitationProbability:precipitationProbability!,
            precipitationIntensity: precipitationIntensity!,
            //precipitationType: precipitationType!,
            dewPoint: dewPoint!,
            humidity: humidity!,
            //windDirection: windDirection!,
            windSpeed: windSpeed!,
            sunriseTime: sunriseTime!,
            sunsetTime: sunsetTime!,
            cloudCover: cloudCover!,
            //weeklySummary: weeklySummary!,
            hourlyForecasts: hourlyForecasts!,
            dailyForecasts: dailyForecasts!,
            //Air quality
            airQualityDescription: airQualityDescription!,
            dominantPollutantDescription: dominantPollutantDescription!,
            recommendationsChildren: recommendationsChildren!,
            recommendationsHealth: recommendationsHealth!,
            recommendationsInside: recommendationsInside!,
            recommendationsOutside: recommendationsOutside!,
            recommendationsSport: recommendationsSport!
            
        )
    }
    
}


