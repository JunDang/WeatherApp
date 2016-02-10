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
    func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherCompletionHandler)
}


typealias FlickrImageCompletionHandler = (UIImage?, Error?) -> Void

protocol FlickrServiceProtocol {
    func searchFlickrForTerm(searchTerm: String, completionHandler: FlickrImageCompletionHandler)
}
