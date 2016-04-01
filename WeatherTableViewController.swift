//
//  WeatherTableViewController.swift
//  WeatherApp
//

//  Created by Jun Dang on 16/2/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    var hourlyForecasts: [HourlyForecast] = []
    var dailyForecasts: [DailyForecast] = [DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°"),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°"),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°" ),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°" ),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°"),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°"),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°" ),
                                           DailyForecast(day: "Monday", dailyIconName: "snowIcon", dailyTemperatureHigh: "33°", dailyTemperatureLow: "19°" )
                                          
                                         ]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 40)
        tableView!.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        tableView!.pagingEnabled = true
        tableView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        tableView!.registerClass(HourlyViewCell.self, forCellReuseIdentifier: "HourlyViewCell")
        tableView!.registerClass(DailyViewCell.self, forCellReuseIdentifier: "DailyViewCell")
        tableView!.registerClass(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
           let cell: HeaderCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderCell
           cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
           return cell
            
        } else if indexPath.row == 1 {
            
               let cell: HourlyViewCell = tableView.dequeueReusableCellWithIdentifier("HourlyViewCell", forIndexPath: indexPath) as! HourlyViewCell
               cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
               cell.updateWeatherData(hourlyForecasts)
               return cell
            
          } else {
            
              let cell: DailyViewCell = tableView.dequeueReusableCellWithIdentifier("DailyViewCell", forIndexPath: indexPath) as! DailyViewCell
              cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
              let dailyForecast = dailyForecasts[indexPath.row - 2]
                cell.dayLabel!.text = dailyForecast.day
                cell.temperatureLow?.text = dailyForecast.dailyTemperatureLow
                cell.temperatureHigh?.text = dailyForecast.dailyTemperatureHigh
                cell.weatherIconLabel?.text = dailyForecast.dailyIconName
                cell.weatherIcon!.image = UIImage(named: "\(cell.weatherIconLabel!.text!)")
            return cell
            
        }
        
    }

    func updateDailyData(dailyForecasts : [DailyForecast]) {
        guard dailyForecasts.count > 0 else {
            return
        }
        self.dailyForecasts = dailyForecasts
        self.tableView.reloadData()
        
    }
    
    func updateHourlyData(hourlyForecasts : [HourlyForecast]) {
        guard hourlyForecasts.count > 0 else {
            return
        }
        self.hourlyForecasts = hourlyForecasts
        self.tableView.reloadData()
    }
    
       
        
        
 }
    


