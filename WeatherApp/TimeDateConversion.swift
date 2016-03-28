//
//  TimeDateConversion.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/26.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation

struct TimeDateConversion {
    let forecastDate: Double
    init(_ date: Double) {
        forecastDate = date
    }
    var hourTime: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = NSDate(timeIntervalSince1970: forecastDate)
        return dateFormatter.stringFromDate(date)
    }
    
    var weekDay: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE"
        let date = NSDate(timeIntervalSince1970: forecastDate)
        let myWeekday = NSCalendar.currentCalendar().component(.Weekday, fromDate: date)
        let array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return array[myWeekday]
        
    }
}
