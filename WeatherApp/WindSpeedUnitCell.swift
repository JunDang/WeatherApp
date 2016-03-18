//
//  WindSpeedUnitCell.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/17.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

enum TemperatureType: Int{
    case Celsius = 0
    case Farenheit
}


class WindSpeedUnitCell: UITableViewCell {

    @IBOutlet weak var windSpeedUnitSegment: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func windSpeedUnitSegmentControl(sender: AnyObject) {
        let temperatureUnit = TemperatureType(rawValue: temperatureSegmentedControl.selectedSegmentIndex)
        switch (temperatureUnit!) {
        case .Celsius:
            print("celcius")
        case .Farenheit:
            print("Farenheit")
            
        }
 
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
}

