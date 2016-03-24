//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/19.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject {
    // MARK: - Constants
    private var EmptyString = ""
    
    // MARK: - Properties
    var hasError: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String?> = Observable(nil)
    
    let location: Observable<String> = Observable("")
    let currentIconName: Observable<String> = Observable("")
    var currentTemperature: Observable<String> = Observable("")
    var currentTemperatureHigh: Observable<String> = Observable("")
    var currentTemperatureLow: Observable<String> = Observable("")
    var feelsLikeTemperature: Observable<String> = Observable("")
    let currentSummary: Observable<String> = Observable("")
    let dailySummary: Observable<String> = Observable("")
    let minutelySummary: Observable<String> = Observable("")
    let precipitationProbability: Observable<String> = Observable("")
    let precipitationIntensity: Observable<String> = Observable("")
    //let precipitationType: Observable<String>
    let dewPoint: Observable<String> = Observable("")
    let humidity: Observable<String> = Observable("")
    //let windDirection: Observable<String>
    var windSpeed: Observable<String> = Observable("")
    let sunriseTime: Observable<String> = Observable("")
    let sunsetTime: Observable<String> = Observable("")
    let cloudCover: Observable<String> = Observable("")
    //let weeklySummary: Observable<String>
    var hourlyForecasts: Observable<[HourlyForecast]> = Observable([])
    var dailyForecasts: Observable<[DailyForecast]> = Observable([])
    // air quality
    let airQualityDescription: Observable<String> = Observable("")
    let dominantPollutantDescription: Observable<String> = Observable("")
    let recommendationsChildren: Observable<String> = Observable("")
    let recommendationsHealth: Observable<String> = Observable("")
    let recommendationsInside: Observable<String> = Observable("")
    let recommendationsOutside: Observable<String> = Observable("")
    let recommendationsSport: Observable<String> = Observable("")
    //unit observer
    var windSpeedUnitCell = WindSpeedUnitCell()
    
     // MARK: - Services
    private var locationService: LocationService!
    private var weatherAirQualityService: WeatherAirQualityServiceProtocol!
    
    // MARK: - init
    override init() {
        super.init()
       /* hasError = Observable(false)
        errorMessage = Observable(nil)
        
        location = Observable(EmptyString)
        currentIconName = Observable(EmptyString)
        currentTemperature = Observable(EmptyString)
        currentTemperatureHigh = Observable(EmptyString)
        currentTemperatureLow = Observable(EmptyString)
        feelsLikeTemperature = Observable(EmptyString)
        currentSummary = Observable(EmptyString)
        dailySummary = Observable(EmptyString)
        minutelySummary = Observable(EmptyString)
        precipitationProbability = Observable(EmptyString)
        precipitationIntensity = Observable(EmptyString)
       // precipitationType = Observable(EmptyString)
        dewPoint = Observable(EmptyString)
        humidity = Observable(EmptyString)
      //  windDirection = Observable(EmptyString)
        windSpeed = Observable(EmptyString)
        sunriseTime = Observable(EmptyString)
        sunsetTime = Observable(EmptyString)
        cloudCover = Observable(EmptyString)
        //weeklySummary = Observable(EmptyString)
        hourlyForecasts = Observable([])
        dailyForecasts = Observable([])
        //air quality
        airQualityDescription = Observable(EmptyString)
        dominantPollutantDescription = Observable(EmptyString)
        recommendationsChildren = Observable(EmptyString)
        recommendationsHealth = Observable(EmptyString)
        recommendationsInside = Observable(EmptyString)
        recommendationsOutside = Observable(EmptyString)
        recommendationsSport = Observable(EmptyString)*/
        print("observer1")
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "convertToKilometer", options: NSKeyValueObservingOptions.New, context: nil)
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "convertToCelsius", options: NSKeyValueObservingOptions.New, context: nil)

        
       
    }
   
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("oberserver2")
        if keyPath == "convertToKilometer" {
            let convertToKilometer =  NSUserDefaults.standardUserDefaults().objectForKey("convertToKilometer") as? Bool
            if convertToKilometer == true {
                  self.windSpeed.value = windSpeedConvertToKPH(self.windSpeed.value)
            } else {
                   self.windSpeed.value = windSpeedConvertToMPH(self.windSpeed.value)
            }
        }
        if keyPath == "convertToCelsius" {
            let convertToCelsius =  NSUserDefaults.standardUserDefaults().objectForKey("convertToCelsius") as? Bool
            if convertToCelsius == true {
                print(currentTemperature)
                self.currentTemperature.value = temperatureConvertToCelcius(self.currentTemperature.value)
                self.currentTemperatureHigh.value = temperatureConvertToCelcius(self.currentTemperatureHigh.value)
                self.currentTemperatureLow.value = temperatureConvertToCelcius(self.currentTemperatureLow.value)
                self.feelsLikeTemperature.value = temperatureConvertToCelcius(self.feelsLikeTemperature.value)
                self.hourlyForecasts.value = hourlyForecastsTemperatureConvertToCelsius(self.hourlyForecasts.value)
                
            } else {
                self.currentTemperature.value = temperatureConvertToFarenheit(self.currentTemperature.value)
                self.currentTemperatureHigh.value = temperatureConvertToFarenheit(self.currentTemperatureHigh.value)
                self.currentTemperatureLow.value = temperatureConvertToFarenheit(self.currentTemperatureLow.value)
                self.feelsLikeTemperature.value = temperatureConvertToFarenheit(self.feelsLikeTemperature.value)
                self.hourlyForecasts.value = hourlyForecastsTemperatureConvertToFarenheit(self.hourlyForecasts.value)
            }
        }
       
    }
    deinit {
        NSUserDefaults.standardUserDefaults().removeObserver(self, forKeyPath: "convertToKilometer", context: nil)
        NSUserDefaults.standardUserDefaults().removeObserver(self, forKeyPath: "convertToCelsius", context: nil)
    }
    func windSpeedConvertToKPH(windSpeedBefore: String) -> String {
        var windSpeedBeforeConversion: Double?
        var windSpeedAfterConversion: Double?
        let windString = windSpeedBefore.componentsSeparatedByString(" ")
         print("windString: \(windString)")
        let windSpeedUnit = windString[2]
        let windDirection = windString[0]
        let windSpeedString = windString[1]
        windSpeedBeforeConversion = Double(windSpeedString)
        if windSpeedUnit == "mph" {
            windSpeedAfterConversion = round(windSpeedBeforeConversion! * 1.609 * 100) / 100
        } else {
            windSpeedAfterConversion = windSpeedBeforeConversion!
        }
            
        return (windDirection + " " + String(windSpeedAfterConversion!) + " " + "km/hr")
    }

    
    func windSpeedConvertToMPH(windSpeedBefore: String) -> String {
        var windSpeedBeforeConversion: Double?
        var windSpeedAfterConversion: Double?
        print(windSpeedBefore)
        let windString = windSpeedBefore.componentsSeparatedByString(" ")
        print(windString)
        let windSpeedUnit = windString[2]
        let windDirection = windString[0]
        let windSpeedString = windString[1]
        print("wss: \(windSpeedString)")
        windSpeedBeforeConversion = Double(windSpeedString)
        print("wbf: \(windSpeedBeforeConversion)")
         if windSpeedUnit == "km/hr" {
            
            windSpeedAfterConversion = round((windSpeedBeforeConversion! / 1.609)*100) / 100
            
            //return (windDirection + " " + String(windSpeedAfterConversion) + " " + "mph")
        } else {
            windSpeedAfterConversion = windSpeedBeforeConversion
        
        }
      return (windDirection + " " + String(windSpeedAfterConversion!) + " " + "mph")
    }
    func temperatureConvertToCelcius(temperatureBefore: String) -> String {
        print("tembeforeF: \(temperatureBefore)")
        var temperatureBeforeConversion: Double?
        var temperatureAfterConversion: Double?
        let temperatureSubstring = temperatureBefore.substringToIndex(temperatureBefore.endIndex.advancedBy(-1))
        //print(temperatureSubstring)
        temperatureBeforeConversion = Double(temperatureSubstring)
    
        temperatureAfterConversion = round((temperatureBeforeConversion! - 32) / 1.8)
        print("tempAfterC: \(temperatureAfterConversion)")
        return (String(Int(temperatureAfterConversion!)) + "\u{00B0}")
    
    }
    func temperatureConvertToFarenheit(temperatureBefore: String) -> String {
        print("tembeforeC: \(temperatureBefore)")
        var temperatureBeforeConversion: Double?
        var temperatureAfterConversion: Double?
        print(temperatureBefore)
        let temperatureSubstring = temperatureBefore.substringToIndex(temperatureBefore.endIndex.advancedBy(-1))
        temperatureBeforeConversion = Double(temperatureSubstring)
        temperatureAfterConversion = round(temperatureBeforeConversion! * 1.8 + 32)
         print("tempAfterF: \(temperatureAfterConversion)")
        return (String(Int(temperatureAfterConversion!)) + "\u{00B0}")
        
    }
        // MARK: - public
    func startLocationService() {
        locationService = LocationService()
        locationService.delegate = self
        
        weatherAirQualityService = WeatherAirQualityService()
        
        locationService.requestLocation()
    }
    
    // MARK: - private
    
    
    private func update(weatherAirQuality: WeatherAirQuality) {
        //self.weatherAirQuality = weatherAirQuality
        self.hasError.value = false
        self.errorMessage.value = nil
        //current. when value passed to observables changed, call observer. Or else, have to change every label name
        self.location.value = weatherAirQuality.location
        self.currentIconName.value = weatherAirQuality.currentIconName
        self.currentTemperature.value = weatherAirQuality.currentTemperature
        self.currentTemperatureHigh.value = weatherAirQuality.currentTemperatureHigh
        self.currentTemperatureLow.value = weatherAirQuality.currentTemperatureLow
        self.feelsLikeTemperature.value = weatherAirQuality.feelsLikeTemperature
        self.currentSummary.value = weatherAirQuality.currentSummary
        self.dailySummary.value = weatherAirQuality.dailySummary
        self.minutelySummary.value = weatherAirQuality.minutelySummary
        self.precipitationProbability.value = weatherAirQuality.precipitationProbability
        self.precipitationIntensity.value = weatherAirQuality.precipitationIntensity
       // self.precipitationType.value = weather.precipitationType
        self.dewPoint.value = weatherAirQuality.dewPoint
        self.humidity.value = weatherAirQuality.humidity
        //self.windDirection.value = weather.windDirection
        self.windSpeed.value = weatherAirQuality.windSpeed
        let convertToKilometer =  NSUserDefaults.standardUserDefaults().objectForKey("convertToKilometer") as? Bool
        if convertToKilometer == true {
            self.windSpeed.value = windSpeedConvertToKPH(self.windSpeed.value)
            
        }
        
        self.sunriseTime.value = weatherAirQuality.sunriseTime
        self.sunsetTime.value = weatherAirQuality.sunsetTime
        self.cloudCover.value = weatherAirQuality.cloudCover
        //self.weeklySummary.value = weather.weeklySummary

        //hourly forecast
        self.hourlyForecasts.value = weatherAirQuality.hourlyForecasts
        //daily forecast
        /*let daily = weather.dailyForecasts.map { dailyForecast in
            return DailyForecast(dailyForecast)
        }*/
        self.dailyForecasts.value = weatherAirQuality.dailyForecasts
        let convertToCelsius =  NSUserDefaults.standardUserDefaults().objectForKey("convertToCelsius") as? Bool
        if convertToCelsius == true {
            self.currentTemperature.value = temperatureConvertToCelcius(self.currentTemperature.value)
            self.currentTemperatureHigh.value = temperatureConvertToCelcius(self.currentTemperatureHigh.value)
            self.currentTemperatureLow.value = temperatureConvertToCelcius(self.currentTemperatureLow.value)
            self.feelsLikeTemperature.value = temperatureConvertToCelcius(self.feelsLikeTemperature.value)
            self.hourlyForecasts.value = hourlyForecastsTemperatureConvertToCelsius(self.hourlyForecasts.value)
            
        }
            
            //air quality
        airQualityDescription.value = weatherAirQuality.airQualityDescription
        dominantPollutantDescription.value = weatherAirQuality.dominantPollutantDescription
        recommendationsChildren.value = weatherAirQuality.recommendationsChildren
        recommendationsHealth.value = weatherAirQuality.recommendationsHealth
        recommendationsInside.value = weatherAirQuality.recommendationsInside
        recommendationsOutside.value = weatherAirQuality.recommendationsOutside
        recommendationsSport.value = weatherAirQuality.recommendationsSport
    
    }
    func hourlyForecastsTemperatureConvertToCelsius(hourlyForecastValue: [HourlyForecast]) -> [HourlyForecast] {
        let hours = self.hourlyForecasts.value.map({$0.time})
        let hourlyIcons = self.hourlyForecasts.value.map({$0.iconName})
        let hourlyTemperatures = self.hourlyForecasts.value.map({temperatureConvertToCelcius($0.temperature)})
        var hourlyForecastsAfterConversion: [HourlyForecast] = []
        for i in 0...24 {
            let hour = hours[i]
            let hourlyIcon = hourlyIcons[i]
            let hourlyTemperature = hourlyTemperatures[i]
            let hourlyForecastAfterConversion = HourlyForecast(time: hour,
                iconName: hourlyIcon,
                temperature: hourlyTemperature)
            hourlyForecastsAfterConversion.append(hourlyForecastAfterConversion)
        }
        
        return hourlyForecastsAfterConversion

    }
    func hourlyForecastsTemperatureConvertToFarenheit(hourlyForecastValue: [HourlyForecast]) -> [HourlyForecast] {
        let hours = self.hourlyForecasts.value.map({$0.time})
        let hourlyIcons = self.hourlyForecasts.value.map({$0.iconName})
        let hourlyTemperatures = self.hourlyForecasts.value.map({temperatureConvertToFarenheit($0.temperature)})
        var hourlyForecastsAfterConversion: [HourlyForecast] = []
        for i in 0...24 {
            let hour = hours[i]
            let hourlyIcon = hourlyIcons[i]
            let hourlyTemperature = hourlyTemperatures[i]
            let hourlyForecastAfterConversion = HourlyForecast(time: hour,
                iconName: hourlyIcon,
                temperature: hourlyTemperature)
            hourlyForecastsAfterConversion.append(hourlyForecastAfterConversion)
        }
        
        return hourlyForecastsAfterConversion
        
    }

    
    private func update(error: Error) {
        self.hasError.value = true
        
        switch error.errorCode {
        case .URLError:
            self.errorMessage.value = "The weather service is not working."
        case .NetworkRequestFailed:
            self.errorMessage.value = "The network appears to be down."
        case .JSONSerializationFailed:
            self.errorMessage.value = "We're having trouble processing weather data."
        case .JSONParsingFailed:
            self.errorMessage.value = "We're having trouble parsing weather data."
        }
        
        self.location.value = self.EmptyString
        self.currentIconName.value = self.EmptyString
        self.currentTemperature.value = self.EmptyString
        self.currentTemperatureHigh.value = self.EmptyString
        self.currentTemperatureLow.value = self.EmptyString
        self.feelsLikeTemperature.value = self.EmptyString
        self.currentSummary.value = self.EmptyString
        self.dailySummary.value = self.EmptyString
        self.minutelySummary.value = self.EmptyString
        self.precipitationProbability.value = self.EmptyString
        self.precipitationIntensity.value = self.EmptyString
        //self.precipitationType.value = self.EmptyString
        self.dewPoint.value = self.EmptyString
        self.humidity.value = self.EmptyString
        //self.windDirection.value = self.EmptyString
        self.windSpeed.value = self.EmptyString
        self.sunriseTime.value = self.EmptyString
        self.sunsetTime.value = self.EmptyString
        self.cloudCover.value = self.EmptyString
        //self.weeklySummary.value = self.EmptyString
        self.hourlyForecasts.value = []
        self.dailyForecasts.value = []
        // air quality
        airQualityDescription.value = self.EmptyString
        dominantPollutantDescription.value = self.EmptyString
        recommendationsChildren.value = self.EmptyString
        recommendationsHealth.value = self.EmptyString
        recommendationsInside.value = self.EmptyString
        recommendationsOutside.value = self.EmptyString
        recommendationsSport.value = self.EmptyString
    }
    
    
    func searchCityLocation(city: String, location: CLLocation) {
        //print("transferredLocation: \(location)")
        weatherAirQualityService.cityName = city
        print(weatherAirQualityService.cityName)
        weatherAirQualityService.retrieveWeatherInfo(location) { (weatherAirQuality, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if let unwrappedError = error {
                    print(unwrappedError)
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedWeather = weatherAirQuality else {
                    return
                }
                self.update(unwrappedWeather)
            })
        }
       
    }
    


}

// MARK: LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
    func locationDidUpdate(service: LocationService, location: CLLocation) {
         weatherAirQualityService.retrieveWeatherInfo(location) { (weatherAirQuality, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if let unwrappedError = error {
                    print(unwrappedError)
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedWeather = weatherAirQuality else {
                    return
                }
                self.update(unwrappedWeather)
            })
        }
    }
    
    
}
