//
//  Graphs.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/2/10.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit
import Charts

class Graphs: UIViewController {

    @IBOutlet weak var hourlyForecast: LineChartView!
  
    var hour:[String] = []
    var hourlyTemperature:[Double] = []
    var hourlyIcon:[String] = []
    var hourlyForecasts: [HourlyForecast] = [HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "1"),
        HourlyForecast(time: "9:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "10:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "11:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0...23 {
            hour.append(hourlyForecasts[index].time)
            print(hour)
            hourlyTemperature.append(Double(hourlyForecasts[index].temperature)!)
            hourlyIcon.append(hourlyForecasts[index].iconName)
        }
        print(hour[0])
        setHourlyChart(hour, values: hourlyTemperature)

      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
   
    func updateHourlyData(hourlyForecasts : [HourlyForecast]) {
        guard hourlyForecasts.count > 0 else {
            return
        }
        self.hourlyForecasts = hourlyForecasts
        print(hourlyForecast)
        
    }
    
    
    /*override func viewWillAppear(animated: Bool) {
        hourlyForecast.notifyDataSetChanged()
        print(hourlyForecasts[0])
        for index in 0...23 {
            hour.append(hourlyForecasts[index].time)
            hourlyTemperature.append(Double(hourlyForecasts[index].temperature)!)
            hourlyIcon.append(hourlyForecasts[index].iconName)
        }
         setHourlyChart(hour, values: hourlyTemperature)
    }*/

    func setHourlyChart(dataPoints: [String], values: [Double]) {
        hourlyForecast.notifyDataSetChanged()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "\u{00B0}")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        hourlyForecast.data = lineChartData
        
    }

}
