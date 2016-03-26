//
//  InternetServices.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/2/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import PromiseKit

enum NetworkError: ErrorType {
    case Empty
    case Short
}

struct WeatherAirQualityService: WeatherAirQualityServiceProtocol {
    //private let baseUrl = "https://api.forecast.io/forecast"
    var convertToKilometer:Bool = false
    var cityName = ""
    
    
    func forecastIO(location: CLLocation) -> Promise<AnyObject> {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let baseUrl = "https://api.forecast.io/forecast"
        let APIKEY = "03d4359e5f3bcc9a216e2900ebea8130"
        let path = "\(baseUrl)/\(APIKEY)/\(latitude),\(longitude)" as URLStringConvertible
        return Promise{ fulfill, reject in
            Alamofire.request(.GET, path).responseJSON
                { response in
                    if let data = response.result.value {
                        fulfill(data)
                    } else {
                        reject(NetworkError.Empty)
                    }
                }
        }
    }

    func breezeoMeter(location: CLLocation) -> Promise<AnyObject> {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let breezoMeterPath = "https://api.breezometer.com/baqi/?lat=\(latitude)&lon=\(longitude)&key=db641ef73ece4b81a351ddf133cb2bc7" as URLStringConvertible
        print(breezoMeterPath)
      
        return Promise{ fulfill, reject in
            Alamofire.request(.GET, breezoMeterPath).responseJSON
                { response in
                    if let data = response.result.value {
                        fulfill(data)
                    } else {
                        reject(NetworkError.Empty)
                    }
            }
        }
    }
    func processResponses(response1: AnyObject , response2: AnyObject, completionHandler: WeatherAirQualityCompletionHandler) -> Void {
        
        //process weather data
        //get current weather data
        let json = JSON(response1)
        guard let currentTemp = json["currently"]["temperature"].double,
            currentMaxTemp = json["daily"]["data"][0]["temperatureMax"].double,
            currentMinTemp = json["daily"]["data"][0]["temperatureMin"].double,
            feelsLikeTemperature = json["currently"]["apparentTemperature"].double,
            currentSummary = json["currently"]["summary"].string,
            dailySummary = json["daily"]["data"][0]["summary"].string,
            precipitationProbability = json["daily"]["data"][0]["precipProbability"].double,
            precipitationIntensity = json["daily"]["data"][0]["precipIntensity"].double,
            dewPoint = json["daily"]["data"][0]["dewPoint"].double,
            humidity = json["daily"]["data"][0]["humidity"].double,
            windBearing = json["daily"]["data"][0]["windBearing"].double,
            windSpeed = json["daily"]["data"][0]["windSpeed"].double,
            sunriseTime = json["daily"]["data"][0]["sunriseTime"].double,
            sunsetTime = json["daily"]["data"][0]["sunsetTime"].double,
            cloudCover = json["daily"]["data"][0]["cloudCover"].double,
            currentIcon = json["currently"]["icon"].string else {
                print("weather error")
                let error = Error(errorCode: .JSONParsingFailed)
                completionHandler(nil, error)
                return
        }
        // print("currentCityName: countryCity")
        // print(json)
        // print(cloudCover)
        /* let weeklySummary: String?
        if json["daily"]["data"]["summary"] != nil {
        weeklySummary = json["daily"]["data"]["summary"].string
        } else {
        weeklySummary = ""
        }*/
        let minutelySummary: String?
        if json["minutely"]["summary"] != nil {
            minutelySummary = json["minutely"]["summary"].string
        } else {
            minutelySummary = ""
        }
        let precipitationType: String?
        if json["daily"]["data"][0]["precipType"] != nil {
            precipitationType = json["daily"]["data"][0]["precipType"].string
        } else {
            precipitationType = ""
        }
        //let currentCity = countryCity.componentsSeparatedByString("/")[1]
        
        var weatherAirQualityBuilder = WeatherAirQualityBuilder()
        let temperature = String(Int(round(currentTemp))) + "\u{00B0}"
          let temperatureSubstring = temperature.substringToIndex(temperature.endIndex.advancedBy(-1))
       // print("temstring: \(temperatureSubstring)")
        let temperatureLow = String(Int(round(currentMinTemp))) + "\u{00B0}"
        let temperatureHigh = String(Int(round(currentMaxTemp))) + "\u{00B0}"
        let feelsLike = String(Int(round(feelsLikeTemperature))) + "\u{00B0}"
        // let calculatingWindDirection = windDegreeTowindDirection(windBearing: windBearing)
        let sunRise = TimeDateConversion(sunriseTime).hourTime
        let sunSet = TimeDateConversion(sunsetTime).hourTime
        let precipitationProb: String = String(Int(precipitationProbability * 100)) + " %"
        let precipitation: String = String(precipitationIntensity) + " cm"
        let dewP: String = String(dewPoint)
        let humidityString: String = String(Int(humidity * 100)) + " %"
             
        let windSpeedString = String(windSpeed) + " " + "mph"
        let cloudCoverString: String = String(cloudCover)
        
        var windDirection: String?
        func windDegreeTowindDirection(windBearing: Double) -> String {
            
            var directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
            
            let i:Int = Int((windBearing + 11.25)/22.5)
            
            windDirection = String(directions[i % 16])
            return windDirection!
            
            
        }
        let calculatingWindDirection = windDegreeTowindDirection(windBearing)
        
        weatherAirQualityBuilder.currentTemperature = temperature
        weatherAirQualityBuilder.currentTemperatureLow = temperatureLow
        weatherAirQualityBuilder.currentTemperatureHigh = temperatureHigh
        weatherAirQualityBuilder.feelsLikeTemperature = feelsLike
        if self.cityName == "" {
            weatherAirQualityBuilder.location = "Current Location"
        } else {
            weatherAirQualityBuilder.location = self.cityName
        }
        weatherAirQualityBuilder.currentSummary = currentSummary
        weatherAirQualityBuilder.dailySummary = dailySummary
        weatherAirQualityBuilder.minutelySummary = minutelySummary
        weatherAirQualityBuilder.precipitationProbability = precipitationProb + " " + precipitationType!
        weatherAirQualityBuilder.precipitationIntensity = precipitation
        //weatherBuilder.precipitationType = precipitationType
        weatherAirQualityBuilder.dewPoint = dewP
        weatherAirQualityBuilder.humidity = humidityString
        //weatherBuilder.windDirection = windDirection.windDirection
        weatherAirQualityBuilder.windSpeed = calculatingWindDirection + " " + windSpeedString
        weatherAirQualityBuilder.sunriseTime = sunRise
        weatherAirQualityBuilder.sunsetTime = sunSet
        weatherAirQualityBuilder.cloudCover = cloudCoverString
        //weatherBuilder.weeklySummary = weeklySummary
       /* let windString = weatherAirQualityBuilder.windSpeed
        let arrayS = windString!.componentsSeparatedByString(" ")
        print(arrayS)
        let numberString = arrayS[1]
        print(numberString)*/
        /*let stringArray = windString!.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        let newString = stringArray.joinWithSeparator("")*/
        //print(stringArray)
        //print(newString)

        let weatherIcon = WeatherIcon().iconMap[currentIcon]
        weatherAirQualityBuilder.currentIconName = weatherIcon
        
        var hourlyForecasts: [HourlyForecast] = []
        for index in 0...24 {
            guard let forecastTempDegrees = json["hourly"]["data"][index]["temperature"].double,
                rawDateTime = json["hourly"]["data"][index]["time"].double,
                forecastIcon = json["hourly"]["data"][index]["icon"].string else {
                    break
            }
            let forecastTemperature = String(Int(round(forecastTempDegrees))) + "\u{00B0}"
            let forecastTimeString = TimeDateConversion(rawDateTime).hourTime
            let forecastWeatherIcon = WeatherIcon().iconMap[forecastIcon]
            let forecast = HourlyForecast(time: forecastTimeString,
                iconName: forecastWeatherIcon!,
                temperature: forecastTemperature)
            
            hourlyForecasts.append(forecast)
            
        }
        weatherAirQualityBuilder.hourlyForecasts = hourlyForecasts
        
        var dailyForecasts: [DailyForecast] = []
        for index in 0...8 {
            guard let dailyTempDegreesHigh = json["daily"]["data"][index]["temperatureMax"].double,
                dailyTempDegreesLow = json["daily"]["data"][index]["temperatureMin"].double,
                rawDateTime = json["daily"]["data"][index]["time"].double,
                dailyForecastIcon = json["daily"]["data"][index]["icon"].string else {
                    break
            }
            
            let dailyTemperatureHigh = String(Int(round(dailyTempDegreesHigh))) + "\u{00B0}"
            let dailyTempeartureLow = String(Int(round(dailyTempDegreesLow))) + "\u{00B0}"
            
            let dailyTimeString = TimeDateConversion(rawDateTime).weekDay
            let dailyWeatherIcon = WeatherIcon().iconMap[dailyForecastIcon]
            
            
            let dailyForecast = DailyForecast(day: dailyTimeString,
                dailyIconName: dailyWeatherIcon!,
                dailyTemperatureHigh: dailyTemperatureHigh,
                dailyTemperatureLow: dailyTempeartureLow)
            
            dailyForecasts.append(dailyForecast)
        }
        
        weatherAirQualityBuilder.dailyForecasts = dailyForecasts
        
        //process air quality data
        //print (response2)
        var airQualityDescription: String?
        var dominantPollutantDescription: String?
        var recommendationsChildren: String?
        var recommendationsHealth: String?
        var recommendationsInside: String?
        var recommendationsOutside: String?
        var recommendationsSport: String?
        let jsonAirQuality = JSON(response2)
        if jsonAirQuality["data_valid"] == false {
            airQualityDescription = "Data not available in this area"
            dominantPollutantDescription = "Data not available in this area"
            recommendationsChildren = "Data not available in this area"
            recommendationsHealth = "Data not available in this area"
            recommendationsInside = "Data not available in this area"
            recommendationsOutside = "Data not available in this area"
            recommendationsSport = "Data not available in this area"
        } else if jsonAirQuality["data_valid"] == true {
            airQualityDescription = jsonAirQuality["breezometer_description"].string!
            dominantPollutantDescription = jsonAirQuality["dominant_pollutant_description"].string!
            recommendationsChildren = jsonAirQuality["random_recommendations"]["children"].string!
            recommendationsHealth = jsonAirQuality["random_recommendations"]["health"].string!
            recommendationsInside = jsonAirQuality["random_recommendations"]["inside"].string!
            recommendationsOutside = jsonAirQuality["random_recommendations"]["outside"].string!
            recommendationsSport = jsonAirQuality["random_recommendations"]["sport"].string!
        } else {
            print("air quality error")
            let error = Error(errorCode: .JSONParsingFailed)
            completionHandler(nil, error)
            return
        }
        weatherAirQualityBuilder.airQualityDescription = airQualityDescription
        weatherAirQualityBuilder.dominantPollutantDescription = dominantPollutantDescription
        weatherAirQualityBuilder.recommendationsChildren = recommendationsChildren
        weatherAirQualityBuilder.recommendationsHealth = recommendationsHealth
        weatherAirQualityBuilder.recommendationsInside = recommendationsInside
        weatherAirQualityBuilder.recommendationsOutside = recommendationsOutside
        weatherAirQualityBuilder.recommendationsSport = recommendationsSport
        
        completionHandler(weatherAirQualityBuilder.buildData(), nil)
   }
    
    func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherAirQualityCompletionHandler) {
        when(forecastIO(location), breezeoMeter(location)).then {
                response1, response2 in
                    self.processResponses(response1, response2: response2, completionHandler: completionHandler)
        }.error { error in
                print(error)
        }
        
        
    }
}
// Flickr search

let apiKey = "14e425ad44c05316fbd17b13a1bf32de"

struct Flickr: FlickrServiceProtocol{
 
       func searchFlickrForTerm(searchTerm: String, completionHandler: FlickrImageCompletionHandler) {
        var backgroundImage = UIImage()
        let searchURL = flickrSearchURLForSearchTerm(searchTerm)
        let searchRequest = NSURLRequest(URL: searchURL)
        
        Alamofire.request(.GET, searchRequest)
            .responseJSON {response in
                guard let data = response.result.value else{
                    print("Request failed with error")
                    return
                }
                //print(data)
                let flickrJson = JSON(data)
                //print(flickrJson)
                let index = Int(arc4random_uniform(24))
                guard let farm = flickrJson["photos"]["photo"][index]["farm"].int,
                          server = flickrJson["photos"]["photo"][index]["server"].string,
                          photoID = flickrJson["photos"]["photo"][index]["id"].string,
                          secret = flickrJson["photos"]["photo"][index]["secret"].string else {
                            
                                      return
                          }
                let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
                let imageURL = flickrPhoto.flickrImageURL()
                print(imageURL)
                
                Alamofire.request(.GET, imageURL)
                    .responseData { response in
                        guard let data = response.result.value else {
                            print("Request failed with error")
                            return
                        }
                       
                        if data.length > 20000 {
                            backgroundImage = UIImage(data: data, scale:1)!
                            completionHandler(backgroundImage, nil)

                          
                        }
                }
           
          }
        
    }
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    private func flickrSearchURLForSearchTerm(searchTerm:String) -> NSURL {
            
        let searchTerm = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        

        let URLString = "https://api.flickr.com/services/rest/?accuracy=11&api_key=\(apiKey)&per_page=25&method=flickr.photos.search&sort=interestingness-desc&tags=\(searchTerm),scenic,landscape,flower,tree,nature,insects,water,sea,cloud,leaf,colorful&tagmode=all&format=json&nojsoncallback=1"
        //print(URLString)
        return NSURL(string: URLString)!
        
        }
        
       
        
}
















