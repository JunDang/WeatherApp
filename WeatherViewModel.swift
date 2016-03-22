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
    let currentTemperature: Observable<String> = Observable("")
    let currentTemperatureHigh: Observable<String> = Observable("")
    let currentTemperatureLow: Observable<String> = Observable("")
    let feelsLikeTemperature: Observable<String> = Observable("")
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
    let hourlyForecasts: Observable<[HourlyForecast]> = Observable([])
    let dailyForecasts: Observable<[DailyForecast]> = Observable([])
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
        
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "convertToKilometer", options: NSKeyValueObservingOptions.New, context: nil)
        print("oberserver1")
        
       // NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "windSpeedUnitSegment", options: NSKeyValueObservingOptions.New, context: nil)
    }
   /* override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "convertToKilometer" {
            print("convertToKilometer")
        }
    }*/
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("oberserver2")
       /* let convertToKilometer =  NSUserDefaults.standardUserDefaults().objectForKey("convertToKilometer") as? Bool
        if convertToKilometer == true {
             var windSpeedBeforeConversion: CGFloat?
             if keyPath == "convertToKilometer" {
             let windString = self.windSpeed.value.componentsSeparatedByString(" ")
             print(windString)
             let windDirection = windString[0]
             let windSpeedString = windString[1]
             if let n = NSNumberFormatter().numberFromString(windSpeedString) {
                windSpeedBeforeConversion = CGFloat(n)
             }
               let windSpeedAfterConversion = windSpeedBeforeConversion! * 1.609
             
               self.windSpeed.value = windDirection + " " + String(windSpeedAfterConversion) + " " + "km/hr"}
            
            
        }*/
        self.windSpeed.value = windUnitChangeResults(self.windSpeed.value)
    }
    deinit {
        NSUserDefaults.standardUserDefaults().removeObserver(self, forKeyPath: "convertToKilometer", context: nil)
        print("observer3")
    }
    func windUnitChangeResults(windSpeedBefore: String) -> String {
        var windSpeedBeforeConversion: CGFloat?
        print(windSpeedBefore)
        let windString = windSpeedBefore.componentsSeparatedByString(" ")
            print(windString)
            let windDirection = windString[0]
            let windSpeedString = windString[1]
            if let n = NSNumberFormatter().numberFromString(windSpeedString) {
                windSpeedBeforeConversion = CGFloat(n)
            }
            let windSpeedAfterConversion = windSpeedBeforeConversion! * 1.609
            
            return (windDirection + " " + String(windSpeedAfterConversion) + " " + "km/hr")
        

    }

    /*func setUserDefaultsListener(){
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "keyPath", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "keyPath" {
            //Do something
        }
    }
    
    deinit {
        NSUserDefaults.standardUserDefaults().removeObserver(self, forKeyPath: "keyPath")
    }*/
    
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
          self.windSpeed.value = windUnitChangeResults(self.windSpeed.value)
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
        //air quality
        airQualityDescription.value = weatherAirQuality.airQualityDescription
        dominantPollutantDescription.value = weatherAirQuality.dominantPollutantDescription
        recommendationsChildren.value = weatherAirQuality.recommendationsChildren
        recommendationsHealth.value = weatherAirQuality.recommendationsHealth
        recommendationsInside.value = weatherAirQuality.recommendationsInside
        recommendationsOutside.value = weatherAirQuality.recommendationsOutside
        recommendationsSport.value = weatherAirQuality.recommendationsSport
    
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
