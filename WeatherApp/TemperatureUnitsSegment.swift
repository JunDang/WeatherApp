//
//  TemperatureUnitsSegment.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/3/16.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import UIKit

/*enum TemperatureType: Int{
    case Celsius = 0
    case Farenheit
}*/

class TemperatureUnitsSegment: UITableViewCell {

    @IBOutlet weak var temperatureSegmentedControl: UISegmentedControl!
    var convertToCelsius: Bool?
    var userDefaults = NSUserDefaults.standardUserDefaults()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        convertToCelsius = userDefaults.objectForKey("convertToCelsius") as? Bool

        
        if (convertToCelsius == nil) {
            convertToCelsius = false
            userDefaults.setObject(convertToCelsius, forKey: "convertToCelsius")
        }
     
        if convertToCelsius == false {
            temperatureSegmentedControl.selectedSegmentIndex = 0
        } else {
            temperatureSegmentedControl.selectedSegmentIndex = 1
        }
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func temperatureUnitSegmentedControl(sender: UISegmentedControl) {
        switch temperatureSegmentedControl.selectedSegmentIndex
        {
        case 0:
            convertToCelsius = false
            print("calledF")
        case 1:
            convertToCelsius = true
            print("calledC")
        default:
            break
        }
        userDefaults.setObject(convertToCelsius, forKey: "convertToCelsius")
        userDefaults.synchronize()
    }
    
 }



    
    
    

