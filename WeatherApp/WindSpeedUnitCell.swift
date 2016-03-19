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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func windSpeedUnitSegmentControl(sender: AnyObject) {
        
            switch windSpeedUnitSegment.selectedSegmentIndex
            {
            case 0:
              print("km/hr")
            case 1:
                print("mph")
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

    
    
}

