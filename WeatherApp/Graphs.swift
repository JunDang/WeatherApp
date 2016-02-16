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
    
    /*var hour:[String] = []
    var hourlyTemperature:[Double] = []
    var hourlyIcon:[String] = []*/
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
        let hours = hourlyForecastsData.map({$0.time})
        print(hours)
        let values = hourlyForecastsData.map({Double($0.temperature.substringToIndex($0.temperature.endIndex.advancedBy(-1)))!})
       // let hourlyIcon = hourlyForecastsData.map({$0.iconName})
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<hours.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "temperature")
        lineChartDataSet.circleRadius = 2.0
        lineChartDataSet.valueFormatter = NSNumberFormatter()
        lineChartDataSet.valueFormatter?.minimumFractionDigits = 0
        let lineChartData = LineChartData(xVals: hours, dataSet: lineChartDataSet)
        lineChartData.setValueFont(UIFont(name: "Avenir", size: 8))
        lineChartData.setDrawValues(true)
//        lineChartData.circleRadius = 10
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
        xAxis.drawGridLinesEnabled = false
        hourlyForecastLineChartView.leftAxis.drawGridLinesEnabled = false;
        hourlyForecastLineChartView.rightAxis.drawGridLinesEnabled = false;
        hourlyForecastLineChartView.rightAxis.enabled = false;
        hourlyForecastLineChartView.legend.enabled = false
        
            // Oy axis setup
        let leftAxis = hourlyForecastLineChartView.leftAxis
        
        //leftAxis.labelFont = [UIFont Caption1];
        leftAxis.labelTextColor = UIColor.whiteColor()
        leftAxis.labelCount = 3;
        leftAxis.labelPosition = .OutsideChart//.YAxisLabelPositionInsideChart
        leftAxis.spaceTop = 0.15;
        leftAxis.axisLineColor = UIColor.whiteColor()
        //leftAxis.removeAllLimitLines()
        
        hourlyForecastLineChartView.data = lineChartData
        //hourlyForecastLineChartView.rightAxis.enabled = false
        //hourlyForecastLineChartView.leftAxis.valueFormatter = NSNumberFormatter()
        //hourlyForecastLineChartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
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

   /* func setHourlyChart(dataPoints: [String], values: [Double]) {
        //hourlyForecast.notifyDataSetChanged()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "\u{00B0}")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        hourlyForecastLineChartView.data = lineChartData
        hourlyForecastLineChartView.notifyDataSetChanged()
        
    }*/

}
