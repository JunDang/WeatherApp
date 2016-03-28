//
//  ServiceProtocol.swift
//  WeatherApp
//

//  Created by Jun Dang on 16/2/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation
import CoreLocation

typealias WeatherAirQualityCompletionHandler = (WeatherAirQuality?, Error?) -> Void

protocol WeatherAirQualityServiceProtocol {
    
    var cityName:String {get set}
    func processResponses(response1: AnyObject , response2: AnyObject, completionHandler: WeatherAirQualityCompletionHandler)
    func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherAirQualityCompletionHandler)
}


typealias FlickrImageCompletionHandler = (UIImage?, Error?) -> Void

protocol FlickrServiceProtocol {
    func searchFlickrForTerm(searchTerm: String, completionHandler: FlickrImageCompletionHandler)
}



