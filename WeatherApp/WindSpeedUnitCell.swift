//
//  WindSpeedUnitCell.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/17.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit



class WindSpeedUnitCell: UITableViewCell {

    @IBOutlet weak var windSpeedUnitSegment: UISegmentedControl!
    var convertToKilometer: Bool?
    var defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("wc1")
        convertToKilometer = defaults.objectForKey("convertToKilometer") as? Bool
        print(convertToKilometer)
        if (convertToKilometer == nil) {
            convertToKilometer = false
            defaults.setObject(convertToKilometer, forKey: "convertToKilometer")
        }
       
        if convertToKilometer == false {
            windSpeedUnitSegment.selectedSegmentIndex = 0
        } else {
            windSpeedUnitSegment.selectedSegmentIndex = 1
        }
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
     
    
    @IBAction func windSpeedUnitSegmentControl(sender: AnyObject) {
        
         print("wc2")
            switch windSpeedUnitSegment.selectedSegmentIndex
            {
            case 0:
                 convertToKilometer = false
                //print(convertToKilometer)
              
                
            case 1:
                 convertToKilometer = true
                
            default: 
                break
            }
        defaults.setObject(convertToKilometer, forKey: "convertToKilometer")
        defaults.synchronize()
    }
   
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}

