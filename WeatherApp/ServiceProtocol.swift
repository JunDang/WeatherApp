//
//  ServiceProtocol.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/2/6.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Weather?, Error?) -> Void

protocol WeatherServiceProtocol {
    var cityName:String {get set}
    func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherCompletionHandler)
}


typealias FlickrImageCompletionHandler = (UIImage?, Error?) -> Void

protocol FlickrServiceProtocol {
    func searchFlickrForTerm(searchTerm: String, completionHandler: FlickrImageCompletionHandler)
}


typealias BreezometerCompletionHandler = (String?, Error?) -> Void

protocol BreezometerServiceProtocol {
    func searchFlickrForTerm(searchTerm: String, completionHandler: BreezometerCompletionHandler)
}
