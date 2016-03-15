//
//  AirQuality.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/2/10.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit


class AirQuality: UIViewController {
    
    @IBOutlet weak var airQualityDescription: UILabel!
    
    @IBOutlet weak var dominantPollutantDescription: UILabel!
    
    @IBOutlet weak var recommendationChildren: UILabel!
    
    @IBOutlet weak var recommendationsHealth: UILabel!
    
    @IBOutlet weak var recommendationsInside: UILabel!
    
    
    @IBOutlet weak var recommendationsOutside: UILabel!
    
    
    @IBOutlet weak var recommendationsSport: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
