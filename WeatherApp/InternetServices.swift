//
//  InternetServices.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/2/6.
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
                               
                //get current weather data
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
                    countryCity = json["timezone"].string,
                    currentIcon = json["currently"]["icon"].string else {
                        let error = Error(errorCode: .JSONParsingFailed)
                        completionHandler(nil, error)
                        return
                }
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
                let currentCity = countryCity.componentsSeparatedByString("/")[1]
                
                var weatherBuilder = WeatherBuilder()
                let temperature = Temperature(forecastIoDegrees: currentTemp)
                let temperatureLow = Temperature(forecastIoDegrees: currentMinTemp)
                let temperatureHigh = Temperature(forecastIoDegrees: currentMaxTemp)
                let feelsLike = Temperature(forecastIoDegrees: feelsLikeTemperature)
               // let calculatingWindDirection = windDegreeTowindDirection(windBearing: windBearing)
                let sunRise = TimeDateConversion(sunriseTime).hourTime
                let sunSet = TimeDateConversion(sunsetTime).hourTime
                let precipitationProb: String = String(Int(precipitationProbability * 100)) + " %"
                let precipitation: String = String(precipitationIntensity) + " cm"
                let dewP: String = String(dewPoint)
                let humidityString: String = String(Int(humidity * 100)) + " %"
                let windSpeedString: String = String(windSpeed) + " km/hr"
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
                
                weatherBuilder.currentTemperature = temperature.degrees
                weatherBuilder.currentTemperatureLow = temperatureLow.degrees
                weatherBuilder.currentTemperatureHigh = temperatureHigh.degrees
                weatherBuilder.feelsLikeTemperature = feelsLike.degrees
                weatherBuilder.location = currentCity
                weatherBuilder.currentSummary = currentSummary
                weatherBuilder.dailySummary = dailySummary
                weatherBuilder.minutelySummary = minutelySummary
                weatherBuilder.precipitationProbability = precipitationProb + " " + precipitationType!
                weatherBuilder.precipitationIntensity = precipitation
                //weatherBuilder.precipitationType = precipitationType
                weatherBuilder.dewPoint = dewP
                weatherBuilder.humidity = humidityString
                //weatherBuilder.windDirection = windDirection.windDirection
                weatherBuilder.windSpeed = calculatingWindDirection + " " + windSpeedString
                weatherBuilder.sunriseTime = sunRise
                weatherBuilder.sunsetTime = sunSet
                weatherBuilder.cloudCover = cloudCoverString
                //weatherBuilder.weeklySummary = weeklySummary
                
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
                //print(imageURL)
                
                Alamofire.request(.GET, imageURL)
                    .responseData { response in
                        guard let data = response.result.value else {
                            print("Request failed with error")
                            return
                        }
                        //print( "data -> \(data.dynamicType)")
                       // print( "data -> \(data.length)")
                        if data.length > 20000 {
                            backgroundImage = UIImage(data: data, scale:1)!
                            print(backgroundImage.size.height)
                            print(backgroundImage.size.width)
                            completionHandler(backgroundImage, nil)
/*
                            if backgroundImage.size.width < 400 {
                               completionHandler(backgroundImage, nil)
                            } else {
                               print("research")
                               let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                       Int64(1 * Double(NSEC_PER_SEC)))
                               dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                                    self.searchFlickrForTerm(searchTerm, completionHandler: completionHandler)
                            }*/
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
    /*func sizeToFill(image: UIImage, size:CGSize) -> CGSize {
        if image.size.height < 100 || image.size.width < 50 {
            return size
        }
        
        let imageSize = image.size
        var returnSize = size
        
        let aspectRatio = imageSize.width / imageSize.height
        
        returnSize.height = returnSize.width / aspectRatio
        
        if returnSize.height > size.height {
            returnSize.height = size.height
            returnSize.width = size.height * aspectRatio
        }
        return returnSize
    }
*/
    
    private func flickrSearchURLForSearchTerm(searchTerm:String) -> NSURL {
            
        let searchTerm = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let URLString = "https://api.flickr.com/services/rest/?accuracy=11&api_key=\(apiKey)&per_page=25&method=flickr.photos.search&sort=interestingness-desc&tags=\(searchTerm),scenic,landscape,flower,tree,nature,insects,water,sea,cloud,leaf,colorful&tagmode=all&format=json&nojsoncallback=1"
        //print(URLString)
        return NSURL(string: URLString)!
        
        }
        
       
        
}


















