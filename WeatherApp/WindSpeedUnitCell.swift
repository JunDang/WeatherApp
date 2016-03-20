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
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var unitChange: Int? = defaults.objectForKey("unitChange") as! Int?
        if (unitChange == nil) {
            unitChange = 1
            defaults.setObject(unitChange, forKey: "windSpeedUnitSegment")
        }
        switch (unitChange!)
        {
        case 0:
            convertToKilometer = true
           
            
        case 1:
            convertToKilometer = false
        default:
            break
        }
        

        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        print("savebuttonPressed")
        let unitChange = windSpeedUnitSegment.selectedSegmentIndex
        defaults.setObject(unitChange, forKey: "unitChange")
        defaults.synchronize()
        
        
        
    }
    

    
    
    
   
    
    
    
    
    
    @IBAction func windSpeedUnitSegmentControl(sender: AnyObject) {
        
        
            switch windSpeedUnitSegment.selectedSegmentIndex
            {
            case 0:
                 convertToKilometer = true
                print(convertToKilometer)
               // WeatherAirQualityService.convertToKilometer = convertToKilometer
                
            case 1:
                 convertToKilometer = false
            default: 
                break
            }
    }
   
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
   /* func viewDidLoad() {
        print("viewDidLoad")
        var unitChange: Int? = defaults.objectForKey("unitChange") as! Int?
        if (unitChange == nil) {
            unitChange = 1
            defaults.setObject(unitChange, forKey: "windSpeedUnitSegment")
        }
        switch (unitChange!)
        {
        case 0:
            convertToKilometer = true
            //WeatherAirQualityService.convertToKilometer = convertToKilometer
            
        case 1:
            convertToKilometer = false
        default:
            break
        }
        

        
    }*/
    
}

