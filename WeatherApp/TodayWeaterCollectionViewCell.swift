//
//  TodayWeaterCollectionViewCell.swift
//  WeatherApp
//
//  Created by Jun Dang on 15/12/9.
//  Copyright © 2015年 Jun Dang. All rights reserved.
//

import UIKit

class TodayWeaterCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    var labelTime: UILabel?
    var labelTemperature: UILabel?
    var iconLabel: UILabel?
    var weatherIcon: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        //add time label
        labelTime = UILabel(frame: CGRectMake(0, 0, 42, 29.5))
        labelTime!.font = UIFont(name: labelTime!.font.fontName, size: 13)
        labelTime!.backgroundColor = UIColor.clearColor()
        labelTime!.textColor = UIColor.whiteColor()
        labelTime!.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(labelTime!)
        
        //add iconLabel. only for getting the icon string for the weatherIcon.
        iconLabel = UILabel(frame: CGRectMake(0, 30, 39, 29.5))
        iconLabel!.font = UIFont(name: labelTime!.font.fontName, size: 10)
        iconLabel!.backgroundColor = UIColor.clearColor()
        iconLabel!.textAlignment = NSTextAlignment.Center
        iconLabel!.hidden = true
        self.contentView.addSubview(iconLabel!)
        
        //add imageView on the iconLabel
        weatherIcon = UIImageView(frame: CGRectMake(0, 30, 42, 30))
        self.contentView.addSubview(weatherIcon!)
        
        //add temperature label
        labelTemperature = UILabel(frame: CGRectMake(0, 60, 42, 29.5))
        labelTemperature!.font = UIFont(name: labelTime!.font.fontName, size: 14)
        labelTemperature!.backgroundColor = UIColor.clearColor()
        labelTemperature!.textColor = UIColor.whiteColor()
        labelTemperature!.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(labelTemperature!)
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
}
