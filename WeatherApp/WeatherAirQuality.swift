//
//  WeatherAirQuality.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/3/11.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//
import Foundation

class WeatherAirQuality{
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
    let dewPoint: String
    let humidity: String
    let windSpeed: String
    let sunriseTime: String
    let sunsetTime: String
    let cloudCover: String

    let hourlyForecasts: [HourlyForecast]
    let dailyForecasts: [DailyForecast]
    
    //Air Quality
    let airQualityDescription: String
    let dominantPollutantDescription: String
    let recommendationsChildren: String
    let recommendationsHealth: String
    let recommendationsInside: String
    let recommendationsOutside: String
    let recommendationsSport: String
    
    init(
        location: String,
        currentIconName: String,
        currentTemperature: String,
        currentTemperatureHigh: String,
        currentTemperatureLow: String,
        feelsLikeTemperature: String,
        currentSummary: String,
        dailySummary: String,
        minutelySummary: String,
        precipitationProbability:String,
        precipitationIntensity: String,
        dewPoint: String,
        humidity: String,
        windSpeed: String,
        sunriseTime: String,
        sunsetTime: String,
        cloudCover: String,
        hourlyForecasts: [HourlyForecast],
        dailyForecasts: [DailyForecast],
        airQualityDescription: String,
        dominantPollutantDescription: String,
        recommendationsChildren: String,
        recommendationsHealth: String,
        recommendationsInside: String,
        recommendationsOutside: String,
        recommendationsSport: String) {
        self.location = location
        self.currentIconName = currentIconName
        self.currentTemperature = currentTemperature
        self.currentTemperatureHigh = currentTemperatureHigh
        self.currentTemperatureLow = currentTemperatureLow
        self.feelsLikeTemperature = feelsLikeTemperature
        
        self.currentSummary = currentSummary
        self.dailySummary = dailySummary
        self.minutelySummary = minutelySummary
        
        self.precipitationProbability = precipitationProbability
        self.precipitationIntensity = precipitationIntensity
        self.dewPoint = dewPoint
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.cloudCover = cloudCover
        
        self.hourlyForecasts = hourlyForecasts
        self.dailyForecasts = dailyForecasts
        
        //Air Quality
        self.airQualityDescription = airQualityDescription
        self.dominantPollutantDescription = dominantPollutantDescription
        self.recommendationsChildren = recommendationsChildren
        self.recommendationsHealth = recommendationsHealth
        self.recommendationsInside = recommendationsInside
        self.recommendationsOutside = recommendationsOutside
        self.recommendationsSport = recommendationsSport
            

    }
}
