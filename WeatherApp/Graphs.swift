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

    @IBOutlet weak var hourlyForecastLineChartView: WeatherLineChartView!
    
    @IBOutlet weak var DailyForecastLineChartView: WeatherLineChartView!
      
    var hourlyForecastsData: [HourlyForecast] = [
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "1"),
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
    var dailyForecastsData: [DailyForecast] = [
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "10", dailyTemperatureLow: "0" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "10", dailyTemperatureLow: "1" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "20", dailyTemperatureLow: "2" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "20", dailyTemperatureLow: "3" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "30", dailyTemperatureLow: "11" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "30", dailyTemperatureLow: "10" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "25", dailyTemperatureLow: "10" ),
                             DailyForecast(day: "Monday", dailyIconName: "weather-snow",dailyTemperatureHigh: "25", dailyTemperatureLow: "9" )
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
   
    func updateHourlyData(hourlyForecastsData : [HourlyForecast]) {
        guard hourlyForecastsData.count > 0 else {
            return
        }
        let iconsNames = hourlyForecastsData.map({$0.iconName})
        print(iconsNames)
        let hours = hourlyForecastsData.map({$0.time})
        print(hours)
        let values = hourlyForecastsData.map({Double($0.temperature.substringToIndex($0.temperature.endIndex.advancedBy(-1)))!})
       // let hourlyIcon = hourlyForecastsData.map({$0.iconName})
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<hours.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = WeatherLineChartDataSet(yVals: dataEntries, label: "temperature")
        lineChartDataSet.circleRadius = 2.0
        lineChartDataSet.valueFormatter = NSNumberFormatter()
        lineChartDataSet.valueFormatter?.minimumFractionDigits = 0
        let lineChartData = LineChartData(xVals: hours, dataSet: lineChartDataSet)
        lineChartData.setValueFont(UIFont(name: "Avenir", size: 8))
        lineChartData.setDrawValues(true)
        lineChartData.setValueTextColor(UIColor.whiteColor())
        hourlyForecastLineChartView.drawGridBackgroundEnabled = false
        //hourlyForecastLineChartView.drawGridBackgroundEnabled = true
        //hourlyForecastLineChartView.drawBordersEnabled = false
        //hourlyForecastLineChartView.xAxis.labelPosition = .Bottom
        let xAxis = hourlyForecastLineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.axisLineColor = UIColor.whiteColor()
        xAxis.labelTextColor = UIColor.whiteColor()
//        xAxis.spaceBetweenLabels = 0.0
        xAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        
        xAxis.drawGridLinesEnabled = false
        hourlyForecastLineChartView.leftAxis.drawGridLinesEnabled = false;
        hourlyForecastLineChartView.rightAxis.drawGridLinesEnabled = false;
        hourlyForecastLineChartView.rightAxis.enabled = false;
        hourlyForecastLineChartView.legend.enabled = false
        
            // y axis setup
        let leftAxis = hourlyForecastLineChartView.leftAxis
        
        //leftAxis.labelFont = [UIFont Caption1];
        leftAxis.labelTextColor = UIColor.whiteColor()
        //leftAxis.labelCount = 3;
        leftAxis.labelPosition = .OutsideChart//.YAxisLabelPositionInsideChart
        leftAxis.spaceTop = 0.15;
        leftAxis.axisLineColor = UIColor.whiteColor()
        leftAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        //leftAxis.removeAllLimitLines()
        
        hourlyForecastLineChartView.data = lineChartData
        //hourlyForecastLineChartView.rightAxis.enabled = false
        hourlyForecastLineChartView.leftAxis.valueFormatter = NSNumberFormatter()
        hourlyForecastLineChartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
        //hourlyForecastLineChartView.descriptionText = ""
       // hourlyForecastLineChartView.
        
        
        /* let data = UIImageJPEGRepresentation((hourlyForecastLineChartView.marker?.image)!, 1)
        let imageSize = data?.length
        print("imageSize1" + "\(imageSize)")*/
        print("size " + "\(hourlyForecastLineChartView.marker)")
        //hourlyForecastLineChartView.marker?.image = UIImage(named: "weather-clear")
               /* let data2 = UIImageJPEGRepresentation((hourlyForecastLineChartView.marker?.image)!, 1)
        let imageSize2 = data2?.length
        print("imageSize2" + "\(imageSize2)")*/
        hourlyForecastLineChartView.notifyDataSetChanged()
        
        }
    
    /*public func draw(context context: CGContext, point: CGPoint)
    {
        let offset = hourlyForecastLineChartView.marker!.offsetForDrawingAtPos(point)
        let size = hourlyForecastLineChartView.marker!.size
        
        let rect = CGRect(x: point.x + offset.x, y: point.y + offset.y, width: size.width, height: size.height)
        
        UIGraphicsPushContext(context)
        hourlyForecastLineChartView.marker!.image!.drawInRect(rect)
        UIGraphicsPopContext()
    }*/
    /*override func viewWillAppear(animated: Bool) {
        //hourlyForecast.notifyDataSetChanged()
        print(hourlyForecastsData[0])
        for index in 0...23 {
            hour.append(hourlyForecastsData[index].time)
            hourlyTemperature.append(Double(hourlyForecastsData[index].temperature)!)
            hourlyIcon.append(hourlyForecastsData[index].iconName)
        }
        setHourlyChart(hour, values: hourlyTemperature)
    }*/

    func updateDailyData(dailyForecastsData : [DailyForecast]) {
        guard dailyForecastsData.count > 0 else {
            return
        }
        let iconsNames = dailyForecastsData.map({$0.dailyIconName})
        print(iconsNames)
        let days = dailyForecastsData.map({$0.day})
        print(days)
        let values = dailyForecastsData.map({Double($0.dailyTemperatureHigh.substringToIndex($0.dailyTemperatureHigh.endIndex.advancedBy(-1)))!})
        // let hourlyIcon = hourlyForecastsData.map({$0.iconName})
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<days.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSetHighTemperature = WeatherLineChartDataSet(yVals: dataEntries, label: "dailyTemperatureHigh")
        lineChartDataSetHighTemperature.circleRadius = 2.0
        lineChartDataSetHighTemperature.valueFormatter = NSNumberFormatter()
        lineChartDataSetHighTemperature.valueFormatter?.minimumFractionDigits = 0
        let lineChartDataHighTemperature = LineChartData(xVals: days, dataSet: lineChartDataSetHighTemperature)
        lineChartDataHighTemperature.setValueFont(UIFont(name: "Avenir", size: 8))
        lineChartDataHighTemperature.setDrawValues(true)
        lineChartDataHighTemperature.setValueTextColor(UIColor.whiteColor())
        DailyForecastLineChartView.drawGridBackgroundEnabled = false
        //hourlyForecastLineChartView.drawGridBackgroundEnabled = true
        //hourlyForecastLineChartView.drawBordersEnabled = false
        //hourlyForecastLineChartView.xAxis.labelPosition = .Bottom
        let xAxis = hourlyForecastLineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.axisLineColor = UIColor.whiteColor()
        xAxis.labelTextColor = UIColor.whiteColor()
        //        xAxis.spaceBetweenLabels = 0.0
        xAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        
        xAxis.drawGridLinesEnabled = false
        DailyForecastLineChartView.leftAxis.drawGridLinesEnabled = false;
        DailyForecastLineChartView.rightAxis.drawGridLinesEnabled = false;
        DailyForecastLineChartView.rightAxis.enabled = false;
        DailyForecastLineChartView.legend.enabled = false
        
        // y axis setup
        let leftAxis = DailyForecastLineChartView.leftAxis
        
        //leftAxis.labelFont = [UIFont Caption1];
        leftAxis.labelTextColor = UIColor.whiteColor()
        //leftAxis.labelCount = 3;
        leftAxis.labelPosition = .OutsideChart//.YAxisLabelPositionInsideChart
        leftAxis.spaceTop = 0.15;
        leftAxis.axisLineColor = UIColor.whiteColor()
        leftAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        //leftAxis.removeAllLimitLines()
        
        DailyForecastLineChartView.data = lineChartDataHighTemperature
        //hourlyForecastLineChartView.rightAxis.enabled = false
        DailyForecastLineChartView.leftAxis.valueFormatter = NSNumberFormatter()
        DailyForecastLineChartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
        //hourlyForecastLineChartView.descriptionText = ""
        // hourlyForecastLineChartView.
        
        
        /* let data = UIImageJPEGRepresentation((hourlyForecastLineChartView.marker?.image)!, 1)
        let imageSize = data?.length
        print("imageSize1" + "\(imageSize)")*/
        print("size " + "\(DailyForecastLineChartView.marker)")
        //hourlyForecastLineChartView.marker?.image = UIImage(named: "weather-clear")
        /* let data2 = UIImageJPEGRepresentation((hourlyForecastLineChartView.marker?.image)!, 1)
        let imageSize2 = data2?.length
        print("imageSize2" + "\(imageSize2)")*/
        DailyForecastLineChartView.notifyDataSetChanged()
        
    }
}
