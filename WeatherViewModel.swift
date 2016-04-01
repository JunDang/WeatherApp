//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/19.
//  Copyright © 2016年 Jun Dang. All rights reserved.
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
    let dewPoint: Observable<String> = Observable("")
    let humidity: Observable<String> = Observable("")
    var windSpeed: Observable<String> = Observable("")
    let sunriseTime: Observable<String> = Observable("")
    let sunsetTime: Observable<String> = Observable("")
    let cloudCover: Observable<String> = Observable("")
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
    
    var currentTemperatureString: String = ""
    var currentTemperatureHighString: String = ""
    var currentTemperatureLowString:  String = ""
    var feelsLikeTemperatureString: String = ""
    var hourlyForecastsArray:[HourlyForecast] = []
    var dailyForecastsArray: [DailyForecast] = []
    
    //unit observer
    var windSpeedUnitCell = WindSpeedUnitCell()
    
     // MARK: - Services
    private var locationService: LocationService!
    private var weatherAirQualityService: WeatherAirQualityServiceProtocol!
    
    // MARK: - init
    override init() {
        super.init()
 
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "convertToKilometer", options: NSKeyValueObservingOptions.New, context: nil)
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "convertToCelsius", options: NSKeyValueObservingOptions.New, context: nil)

    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
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
                 self.currentTemperature.value = temperatureConvertToCelcius(self.currentTemperatureString)
                self.currentTemperatureHigh.value = temperatureConvertToCelcius(self.currentTemperatureHighString)
                self.currentTemperatureLow.value = temperatureConvertToCelcius(self.currentTemperatureLowString)
                self.feelsLikeTemperature.value = temperatureConvertToCelcius(self.feelsLikeTemperatureString)
                self.hourlyForecasts.value = hourlyForecastsTemperatureConvertToCelsius(self.hourlyForecastsArray)
                self.dailyForecasts.value = dailyForecastsTemperatureConvertToCelsius(self.dailyForecastsArray)
             } else {
                self.currentTemperature.value = self.currentTemperatureString
                self.currentTemperatureHigh.value = self.currentTemperatureHighString
                self.currentTemperatureLow.value = self.currentTemperatureLowString
                self.feelsLikeTemperature.value = self.feelsLikeTemperatureString
                self.hourlyForecasts.value = self.hourlyForecastsArray
                self.dailyForecasts.value = self.dailyForecastsArray
                print("modelDaily1: \(self.dailyForecasts.value)")
            }
        
        }
        
    }
    
    deinit {
        NSUserDefaults.standardUserDefaults().removeObserver(self, forKeyPath: "convertToKilometer", context: nil)
        NSUserDefaults.standardUserDefaults().removeObserver(self, forKeyPath: "convertToCelsius", context: nil)
    }
    
    func windSpeedConvertToKPH(windSpeedBefore: String) -> String {
        var windSpeedBeforeConversion: Double = 0.0
        var windSpeedAfterConversion: Double = 0.0
        guard windSpeedBefore.characters.count > 0 else {
            print("empty data")
            return("nil 0 nil")
        }
        let windString = windSpeedBefore.componentsSeparatedByString(" ")
        let windSpeedUnit = windString[2]
        let windDirection = windString[0]
        let windSpeedString = windString[1]
        windSpeedBeforeConversion = Double(windSpeedString)!
        if windSpeedUnit == "mph" {
            windSpeedAfterConversion = round(windSpeedBeforeConversion * 1.609 * 100) / 100
        } else {
            windSpeedAfterConversion = windSpeedBeforeConversion
        }
            
        return (windDirection + " " + String(windSpeedAfterConversion) + " " + "km/hr")
    }

    
    func windSpeedConvertToMPH(windSpeedBefore: String) -> String {
        var windSpeedBeforeConversion: Double = 0.0
        var windSpeedAfterConversion: Double = 0.0
        guard windSpeedBefore.characters.count > 0 else {
           print("empty data")
           return("nil 0 nil")
        }
        let windString = windSpeedBefore.componentsSeparatedByString(" ")
       
        let windSpeedUnit = windString[2]
        let windDirection = windString[0]
        let windSpeedString = windString[1]

        windSpeedBeforeConversion = Double(windSpeedString)!
        if windSpeedUnit == "km/hr" {
          
            windSpeedAfterConversion = round((windSpeedBeforeConversion / 1.609)*100) / 100
            
           } else {
            windSpeedAfterConversion = windSpeedBeforeConversion
        
           }
        
        return (windDirection + " " + String(windSpeedAfterConversion) + " " + "mph")
    }
    
    func temperatureConvertToCelcius(temperatureBefore: String) -> String {
        var temperatureBeforeConversion: Double?
        var temperatureAfterConversion: Double?
        guard temperatureBefore.characters.count > 0 else {
            return "data not available"
        }
        let temperatureSubstring = temperatureBefore.substringToIndex(temperatureBefore.endIndex.advancedBy(-1))
     
        temperatureBeforeConversion = Double(temperatureSubstring)
    
        temperatureAfterConversion = round((temperatureBeforeConversion! - 32) / 1.8)
        return (String(Int(temperatureAfterConversion!)) + "\u{00B0}")
    
    }
    
    func temperatureConvertToFarenheit(temperatureBefore: String) -> String {
        var temperatureBeforeConversion: Double?
        var temperatureAfterConversion: Double?
        guard temperatureBefore.characters.count > 0 else {
            return "data not available"
        }
        let temperatureSubstring = temperatureBefore.substringToIndex(temperatureBefore.endIndex.advancedBy(-1))
        temperatureBeforeConversion = Double(temperatureSubstring)
        temperatureAfterConversion = round(temperatureBeforeConversion! * 1.8 + 32)
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

        self.hasError.value = false
        self.errorMessage.value = nil
        self.location.value = weatherAirQuality.location
        self.currentIconName.value = weatherAirQuality.currentIconName
        self.currentTemperature.value = weatherAirQuality.currentTemperature
        self.currentTemperatureString = weatherAirQuality.currentTemperature
        self.currentTemperatureHigh.value = weatherAirQuality.currentTemperatureHigh
        self.currentTemperatureHighString = weatherAirQuality.currentTemperatureHigh
        self.currentTemperatureLow.value = weatherAirQuality.currentTemperatureLow
        self.currentTemperatureLowString = weatherAirQuality.currentTemperatureLow
        self.feelsLikeTemperature.value = weatherAirQuality.feelsLikeTemperature
        self.feelsLikeTemperatureString = weatherAirQuality.feelsLikeTemperature
        self.currentSummary.value = weatherAirQuality.currentSummary
        self.dailySummary.value = weatherAirQuality.dailySummary
        self.minutelySummary.value = weatherAirQuality.minutelySummary
        self.precipitationProbability.value = weatherAirQuality.precipitationProbability
        self.precipitationIntensity.value = weatherAirQuality.precipitationIntensity
        self.dewPoint.value = weatherAirQuality.dewPoint
        self.humidity.value = weatherAirQuality.humidity
        self.windSpeed.value = weatherAirQuality.windSpeed
        let convertToKilometer =  NSUserDefaults.standardUserDefaults().objectForKey("convertToKilometer") as? Bool
        if convertToKilometer == true {
            self.windSpeed.value = windSpeedConvertToKPH(self.windSpeed.value)
            
        }
        
        self.sunriseTime.value = weatherAirQuality.sunriseTime
        self.sunsetTime.value = weatherAirQuality.sunsetTime
        self.cloudCover.value = weatherAirQuality.cloudCover
        //hourly forecast
        self.hourlyForecasts.value = weatherAirQuality.hourlyForecasts
        self.hourlyForecastsArray = weatherAirQuality.hourlyForecasts
        //daily forecast
        self.dailyForecasts.value = weatherAirQuality.dailyForecasts
        self.dailyForecastsArray = weatherAirQuality.dailyForecasts
        print("dailyForecastsArray: \(dailyForecastsArray)")
        let convertToCelsius =  NSUserDefaults.standardUserDefaults().objectForKey("convertToCelsius") as? Bool
        if convertToCelsius == true {
            self.currentTemperature.value = temperatureConvertToCelcius(self.currentTemperature.value)
            self.currentTemperatureHigh.value = temperatureConvertToCelcius(self.currentTemperatureHigh.value)
            self.currentTemperatureLow.value = temperatureConvertToCelcius(self.currentTemperatureLow.value)
            self.feelsLikeTemperature.value = temperatureConvertToCelcius(self.feelsLikeTemperature.value)
            self.hourlyForecasts.value = hourlyForecastsTemperatureConvertToCelsius(self.hourlyForecasts.value)
            self.dailyForecasts.value = dailyForecastsTemperatureConvertToCelsius(self.dailyForecasts.value)
            
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
        let hours = hourlyForecastValue.map({$0.time})
        let hourlyIcons = hourlyForecastValue.map({$0.iconName})
        let hourlyTemperatures = hourlyForecastValue.map({temperatureConvertToCelcius($0.temperature)})
        var hourlyForecastsAfterConversion: [HourlyForecast] = []
        for i in 0..<hourlyForecastValue.count {
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
        let hours = hourlyForecastValue.map({$0.time})
        let hourlyIcons = hourlyForecastValue.map({$0.iconName})
        let hourlyTemperatures = hourlyForecastValue.map({temperatureConvertToCelcius($0.temperature)})
        var hourlyForecastsAfterConversion: [HourlyForecast] = []
        for i in 0..<hourlyForecastValue.count {
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
    func dailyForecastsTemperatureConvertToCelsius(dailyForecastValue: [DailyForecast]) -> [DailyForecast] {
        let days = dailyForecastValue.map({$0.day})
        let dailyIcons = dailyForecastValue.map({$0.dailyIconName})
        let dailyHighTemperatures = dailyForecastValue.map({temperatureConvertToCelcius($0.dailyTemperatureHigh)})
        let dailyLowTemperatures = dailyForecastValue.map({temperatureConvertToCelcius($0.dailyTemperatureLow)})
   
        var dailyForecastsAfterConversion: [DailyForecast] = []
        for i in 0..<dailyForecastValue.count {
            let day = days[i]
            let dailyIcon = dailyIcons[i]
            let dailyHighTemperature = dailyHighTemperatures[i]
            let dailyLowTemperature = dailyLowTemperatures[i]
            
            let dailyForecastAfterConversion = DailyForecast(day: day,
                dailyIconName: dailyIcon,
                dailyTemperatureHigh: dailyHighTemperature,
                dailyTemperatureLow: dailyLowTemperature)
            
            dailyForecastsAfterConversion.append(dailyForecastAfterConversion)
        }
        
        return dailyForecastsAfterConversion
        
    }
    func dailyForecastsTemperatureConvertToFarenheit(dailyForecastValue: [DailyForecast]) -> [DailyForecast] {
        let days = dailyForecastValue.map({$0.day})
        let dailyIcons = dailyForecastValue.map({$0.dailyIconName})
        let dailyHighTemperatures = dailyForecastValue.map({temperatureConvertToFarenheit($0.dailyTemperatureHigh)})
        let dailyLowTemperatures = dailyForecastValue.map({temperatureConvertToFarenheit($0.dailyTemperatureLow)})
        
        var dailyForecastsAfterConversion: [DailyForecast] = []
        for i in 0..<dailyForecastValue.count {
            let day = days[i]
            let dailyIcon = dailyIcons[i]
            let dailyHighTemperature = dailyHighTemperatures[i]
            let dailyLowTemperature = dailyLowTemperatures[i]
            
            let dailyForecastAfterConversion = DailyForecast(day: day,
                dailyIconName: dailyIcon,
                dailyTemperatureHigh: dailyHighTemperature,
                dailyTemperatureLow: dailyLowTemperature)
            
            dailyForecastsAfterConversion.append(dailyForecastAfterConversion)
        }
        
        return dailyForecastsAfterConversion
        
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
        self.dewPoint.value = self.EmptyString
        self.humidity.value = self.EmptyString
        self.windSpeed.value = self.EmptyString
        self.sunriseTime.value = self.EmptyString
        self.sunsetTime.value = self.EmptyString
        self.cloudCover.value = self.EmptyString
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
    
        weatherAirQualityService.cityName = city
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
