//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/14.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation
import CoreLocation

import Alamofire

struct WeatherService: WeatherServiceProtocol {
    private let baseUrl = "https://api.forecast.io/forecast"
    
    //WARNING Replace it with your own APIKEY from developer.forecast.io
    /// API KEY for forecast.io (needs registration - free)
    let APIKEY = "03d4359e5f3bcc9a216e2900ebea8130"
    
    func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherCompletionHandler) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let path = "\(baseUrl)/\(APIKEY)/\(latitude),\(longitude)" as URLStringConvertible
        
        Alamofire.request(.GET, path)
            .responseJSON {response in
                guard let data = response.result.value else{
                    print("Request failed with error")
                    return
                }
                //print(data)
                let json = JSON(data)
                //print(json)
                //get current weather data
                guard let currentTemp = json["currently"]["temperature"].double,
                          currentMaxTemp = json["daily"]["data"][0]["temperatureMax"].double,
                          currentMinTemp = json["daily"]["data"][0]["temperatureMin"].double,
                          countryCity = json["timezone"].string,
                          currentIcon = json["currently"]["icon"].string else {
                        let error = Error(errorCode: .JSONParsingFailed)
                        completionHandler(nil, error)
                        return
                }
       
                
                let currentCity = countryCity.componentsSeparatedByString("/")[1]
             
                var weatherBuilder = WeatherBuilder()
                let temperature = Temperature(forecastIoDegrees: currentTemp)
                let temperatureLow = Temperature(forecastIoDegrees: currentMaxTemp)
                let temperatureHigh = Temperature(forecastIoDegrees: currentMinTemp)
                
                weatherBuilder.currentTemperature = temperature.degrees
                weatherBuilder.currentTemperatureLow = temperatureLow.degrees
                weatherBuilder.currentTemperatureHigh = temperatureHigh.degrees
                weatherBuilder.location = currentCity
                
                let weatherIcon = WeatherIcon().iconMap[currentIcon]
                weatherBuilder.currentIconName = weatherIcon
    
                var hourlyForecasts: [HourlyForecast] = []
                for index in 0...24 {
                    guard let forecastTempDegrees = json["hourly"]["data"][index]["temperature"].double,
                        rawDateTime = json["hourly"]["data"][index]["time"].double,
                        forecastIcon = json["hourly"]["data"][index]["icon"].string else {
                            break
                }
                    let forecastTemperature = Temperature(forecastIoDegrees: forecastTempDegrees)
                    let forecastTimeString = TimeDateConversion(rawDateTime).hourTime
                    let forecastWeatherIcon = WeatherIcon().iconMap[forecastIcon]
                    let forecast = HourlyForecast(time: forecastTimeString,
                        iconName: forecastWeatherIcon!,
                        temperature: forecastTemperature.degrees)
                    
                     hourlyForecasts.append(forecast)
                    
                }
                     weatherBuilder.hourlyForecasts = hourlyForecasts
                
                    var dailyForecasts: [DailyForecast] = []
                    for index in 0...8 {
                        guard let dailyTempDegreesHigh = json["daily"]["data"][index]["temperatureMax"].double,
                                  dailyTempDegreesLow = json["daily"]["data"][index]["temperatureMin"].double,
                                  rawDateTime = json["daily"]["data"][index]["time"].double,
                                  dailyForecastIcon = json["daily"]["data"][index]["icon"].string else {
                                break
                        }
                     
                        let dailyTemperatureHigh = Temperature(forecastIoDegrees: dailyTempDegreesHigh)
                        let dailyTempeartureLow = Temperature(forecastIoDegrees: dailyTempDegreesLow)

                        let dailyTimeString = TimeDateConversion(rawDateTime).weekDay
                        let dailyWeatherIcon = WeatherIcon().iconMap[dailyForecastIcon]
                 
                        
                        let dailyForecast = DailyForecast(day: dailyTimeString,
                            dailyIconName: dailyWeatherIcon!,
                            dailyTemperatureHigh: dailyTemperatureHigh.degrees,
                            dailyTemperatureLow: dailyTempeartureLow.degrees)
                        
                        dailyForecasts.append(dailyForecast)
             }
               
                weatherBuilder.dailyForecasts = dailyForecasts
               // print(weatherBuilder.hourlyForecasts)
                completionHandler(weatherBuilder.build(), nil)
        }

      }
    
      
     
    }

  



