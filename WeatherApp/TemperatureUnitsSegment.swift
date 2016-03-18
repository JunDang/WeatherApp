//
//  TemperatureUnitsSegment.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/16.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

enum TemperatureType: Int{
    case Celsius = 0
    case Farenheit
}

class TemperatureUnitsSegment: UITableViewCell {

    @IBOutlet weak var temperatureSegmentedControl: UISegmentedControl!
    
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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func temperatureUnitSegmentedControl(sender: UISegmentedControl) {
        let temperatureUnit = TemperatureType(rawValue: temperatureSegmentedControl.selectedSegmentIndex)
        switch (temperatureUnit!) {
        case .Celsius:
            print("celcius")
        case .Farenheit:
            print("Farenheit")
            
        }

        
    }
    
    
    
}
