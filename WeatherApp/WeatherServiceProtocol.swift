//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/14.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Weather?, Error?) -> Void

protocol WeatherServiceProtocol {
    func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherCompletionHandler)
}


