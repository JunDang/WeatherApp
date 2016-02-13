//
//  Summary.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/2/10.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

class Summary: UIViewController {
    
   
    @IBOutlet weak var TodayLabel: UILabel!
    @IBOutlet weak var precipType: UILabel!
    @IBOutlet weak var weeklySummary: UILabel!
    @IBOutlet weak var cloudCover: UILabel!
    @IBOutlet weak var dailySummary: UILabel!
    @IBOutlet weak var precipitationProbability: UILabel!
    @IBOutlet weak var precipitationIntensity: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        // Do any additional setup after loading the view.
        
        
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
  
  }
