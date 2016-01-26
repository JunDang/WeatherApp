//
//  ForecastDateTime.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/6.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import Foundation

struct ForecastDateTime {
    let rawDate: Double
    init(_ date: Double) {
        rawDate = date
    }
    var shortTime: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = NSDate(timeIntervalSince1970: rawDate)
        return dateFormatter.stringFromDate(date)
    }
    
    var weekDay: String {
       let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE"
       let date = NSDate(timeIntervalSince1970: rawDate)
       let myWeekday = NSCalendar.currentCalendar().component(.Weekday, fromDate: date)
       let array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Tuesday", "Thursday", "Friday", "Saturday"]
       return array[myWeekday]
        
    }
}
