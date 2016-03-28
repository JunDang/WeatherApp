//
//  Graphs.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/2/10.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import UIKit
import Charts

class Graphs: UIViewController {

    @IBOutlet weak var hourlyForecastLineChartView: WeatherLineChartView!
    
    @IBOutlet weak var DailyForecastLineChartView: WeatherLineChartView!
      
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
       
    }
   
    func updateHourlyData(hourlyForecastsData : [HourlyForecast]) {
        guard hourlyForecastsData.count > 0 else {
            return
        }
       
        
        let hours = hourlyForecastsData.map({$0.time})
       
        let values = hourlyForecastsData.map({Double($0.temperature.substringToIndex($0.temperature.endIndex.advancedBy(-1)))!})
   
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<hours.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Temperature(°)")
        lineChartDataSet.circleRadius = 2.0
        lineChartDataSet.valueFormatter = NSNumberFormatter()
        lineChartDataSet.valueFormatter?.minimumFractionDigits = 0
        // x axis setup
        let xAxis = hourlyForecastLineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.axisLineColor = UIColor.whiteColor()
        xAxis.labelTextColor = UIColor.whiteColor()
        //xAxis.spaceBetweenLabels = 0.0
        xAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
     
        // y axis setup
        let leftAxis = hourlyForecastLineChartView.leftAxis
        leftAxis.drawGridLinesEnabled = false
        leftAxis.labelTextColor = UIColor.whiteColor()
        leftAxis.labelPosition = .OutsideChart
        leftAxis.spaceTop = 0.15;
        leftAxis.axisLineColor = UIColor.whiteColor()
        leftAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        leftAxis.valueFormatter = NSNumberFormatter()
        leftAxis.valueFormatter?.minimumFractionDigits = 0
        //leftAxis.removeAllLimitLines()
        
        hourlyForecastLineChartView.rightAxis.drawGridLinesEnabled = false
        hourlyForecastLineChartView.rightAxis.enabled = false
        hourlyForecastLineChartView.legend.enabled = true
        hourlyForecastLineChartView.legend.textColor = UIColor.whiteColor()
        hourlyForecastLineChartView.legend.formSize = CGFloat(6.0)

        
        
        let lineChartData = LineChartData(xVals: hours, dataSet: lineChartDataSet)
        lineChartData.setValueFont(UIFont(name: "Avenir", size: 8))
        lineChartData.setDrawValues(true)
        lineChartData.setValueTextColor(UIColor.whiteColor())
        hourlyForecastLineChartView.drawGridBackgroundEnabled = false
        hourlyForecastLineChartView.data = lineChartData
        
        hourlyForecastLineChartView.notifyDataSetChanged()
        
        }
     // draw daily forecast graph
    func updateDailyData(dailyForecastsData : [DailyForecast]) {
        guard dailyForecastsData.count > 0 else {
            return
        }
        
        let days = dailyForecastsData.map({$0.day})
      
        //high temperature
        let valuesHighTemperature = dailyForecastsData.map({Double($0.dailyTemperatureHigh.substringToIndex($0.dailyTemperatureHigh.endIndex.advancedBy(-1)))!})
        var dataEntriesHighTemperature: [ChartDataEntry] = []
        for i in 0..<days.count {
            let dataEntryHighTemperature = ChartDataEntry(value: valuesHighTemperature[i], xIndex: i)
            dataEntriesHighTemperature.append(dataEntryHighTemperature)
        }
        let highTemperatureSet = LineChartDataSet(yVals: dataEntriesHighTemperature, label: "Temperature High(°)")
        highTemperatureSet.axisDependency = .Left
        highTemperatureSet.circleRadius = 2.0
        highTemperatureSet.valueFormatter = NSNumberFormatter()
        highTemperatureSet.valueFormatter?.minimumFractionDigits = 0
        highTemperatureSet.setColor(UIColor.redColor())
        highTemperatureSet.setCircleColor(UIColor.redColor())

        //low tempreature
        let valuesLowTemperature = dailyForecastsData.map({Double($0.dailyTemperatureLow.substringToIndex($0.dailyTemperatureLow.endIndex.advancedBy(-1)))!})
              var dataEntriesLowTemperature: [ChartDataEntry] = []
        for i in 0..<days.count {
            let dataEntryLowTemperature = ChartDataEntry(value: valuesLowTemperature[i], xIndex: i)
            dataEntriesLowTemperature.append(dataEntryLowTemperature)
        }
        let lowTemperatureSet = LineChartDataSet(yVals: dataEntriesLowTemperature, label: "Temperature Low(°)")
        lowTemperatureSet.axisDependency = .Left
        lowTemperatureSet.circleRadius = 2.0
        lowTemperatureSet.valueFormatter = NSNumberFormatter()
        lowTemperatureSet.valueFormatter?.minimumFractionDigits = 0
        lowTemperatureSet.setColor(UIColor.yellowColor())
        lowTemperatureSet.setCircleColor(UIColor.yellowColor())
        //create datasets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(highTemperatureSet)
        dataSets.append(lowTemperatureSet)
        
        let data: LineChartData = LineChartData(xVals: days, dataSets: dataSets)
        data.setValueTextColor(UIColor.whiteColor())
        data.setValueFont(UIFont(name: "Avenir", size: 8))
        data.setDrawValues(true)
        DailyForecastLineChartView.data = data
        DailyForecastLineChartView.drawGridBackgroundEnabled = false
        let xAxis = DailyForecastLineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.axisLineColor = UIColor.whiteColor()
        xAxis.labelTextColor = UIColor.whiteColor()
        // xAxis.spaceBetweenLabels = 0.0
        xAxis.labelFont = UIFont(name: "Avenir", size: 8)!
        
        xAxis.drawGridLinesEnabled = false
        DailyForecastLineChartView.leftAxis.drawGridLinesEnabled = false
        DailyForecastLineChartView.rightAxis.drawGridLinesEnabled = false
        DailyForecastLineChartView.rightAxis.enabled = false
        DailyForecastLineChartView.legend.enabled = true
        DailyForecastLineChartView.legend.textColor = UIColor.whiteColor()
        DailyForecastLineChartView.legend.formSize = CGFloat(6.0)
        
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
        
        DailyForecastLineChartView.leftAxis.valueFormatter = NSNumberFormatter()
        DailyForecastLineChartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
          
        DailyForecastLineChartView.notifyDataSetChanged()
        
    }
}
