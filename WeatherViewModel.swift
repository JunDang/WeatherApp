//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/19.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    // MARK: - Constants
    private let EmptyString = ""
    
    // MARK: - Properties
    let hasError: Observable<Bool>
    let errorMessage: Observable<String?>
    
    let location: Observable<String>
    let currentIconName: Observable<String>
    let currentTemperature: Observable<String>
    let currentTemperatureHigh: Observable<String>
    let currentTemperatureLow: Observable<String>
    let feelsLikeTemperature: Observable<String>
    let currentSummary: Observable<String>
    let dailySummary: Observable<String>
    let minutelySummary: Observable<String>
    let precipitationProbability: Observable<String>
    let precipitationType: Observable<String>
    let precipitationIntensity: Observable<String>
    let dewPoint: Observable<String>
    let humidity: Observable<String>
    let windDirection: Observable<String>
    let windSpeed: Observable<String>
    let sunriseTime: Observable<String>
    let sunsetTime: Observable<String>
    let cloudCover: Observable<String>
    let hourlyForecasts: Observable<[HourlyForecast]>
    let dailyForecasts: Observable<[DailyForecast]>

     // MARK: - Services
    private var locationService: LocationService!
    private var weatherService: WeatherServiceProtocol!
    
    // MARK: - init
    init() {
        hasError = Observable(false)
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
        precipitationType = Observable(EmptyString)
        precipitationIntensity = Observable(EmptyString)
        dewPoint = Observable(EmptyString)
        humidity = Observable(EmptyString)
        windDirection = Observable(EmptyString)
        windSpeed = Observable(EmptyString)
        sunriseTime = Observable(EmptyString)
        sunsetTime = Observable(EmptyString)
        cloudCover = Observable(EmptyString)
        hourlyForecasts = Observable([])
        dailyForecasts = Observable([])
    }
    
    // MARK: - public
    func startLocationService() {
        locationService = LocationService()
        locationService.delegate = self
        
        weatherService = WeatherService()
        
        locationService.requestLocation()
    }
    
    // MARK: - private
    
    private func update(weather: Weather) {
        self.hasError.value = false
        self.errorMessage.value = nil
        //current. when value passed to observables changed, call observer. Or else, have to change every label name
        self.location.value = weather.location
        self.currentIconName.value = weather.currentIconName
        self.currentTemperature.value = weather.currentTemperature
        self.currentTemperatureHigh.value = weather.currentTemperatureHigh
        self.currentTemperatureLow.value = weather.currentTemperatureLow
        self.feelsLikeTemperature.value = weather.feelsLikeTemperature
        self.currentSummary.value = weather.currentSummary
        self.dailySummary.value = weather.dailySummary
        self.minutelySummary.value = weather.minutelySummary
        self.precipitationProbability.value = weather.precipitationProbability
        self.precipitationType.value = weather.precipitationType
        self.precipitationIntensity.value = weather.precipitationIntensity
        self.dewPoint.value = weather.dewPoint
        self.humidity.value = weather.humidity
        self.windDirection.value = weather.windDirection
        self.windSpeed.value = weather.windSpeed
        self.sunriseTime.value = weather.sunriseTime
        self.sunsetTime.value = weather.sunsetTime
        self.cloudCover.value = weather.cloudCover

        //hourly forecast
        self.hourlyForecasts.value = weather.hourlyForecasts
        //daily forecast
        /*let daily = weather.dailyForecasts.map { dailyForecast in
            return DailyForecast(dailyForecast)
        }*/
        self.dailyForecasts.value = weather.dailyForecasts
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
        self.precipitationType.value = self.EmptyString
        self.precipitationIntensity.value = self.EmptyString
        self.dewPoint.value = self.EmptyString
        self.humidity.value = self.EmptyString
        self.windDirection.value = self.EmptyString
        self.windSpeed.value = self.EmptyString
        self.sunriseTime.value = self.EmptyString
        self.sunsetTime.value = self.EmptyString
        self.cloudCover.value = self.EmptyString
        self.hourlyForecasts.value = []
        self.dailyForecasts.value = []
    }
}

// MARK: LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
    func locationDidUpdate(service: LocationService, location: CLLocation) {
          weatherService.retrieveWeatherInfo(location) { (weather, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if let unwrappedError = error {
                    print(unwrappedError)
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedWeather = weather else {
                    return
                }
                self.update(unwrappedWeather)
            })
        }
    }
}
