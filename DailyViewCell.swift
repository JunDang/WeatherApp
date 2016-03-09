//
//  DailyViewCell.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/23.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

class DailyViewCell: UITableViewCell {

    let dayLabel: UILabel? = UILabel()
    let temperatureLow: UILabel? = UILabel()
    let temperatureHigh: UILabel? = UILabel()
    var weatherIconLabel: UILabel? = UILabel()
    var weatherIcon: UIImageView? = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        //create day label
        let font = UIFont(name: "Arial", size: 20.0)
        dayLabel!.font = font
        dayLabel!.backgroundColor = UIColor.clearColor()
        dayLabel!.textAlignment = NSTextAlignment.Left
        dayLabel!.textColor = UIColor.whiteColor()
        self.contentView.addSubview(dayLabel!)
        let toTopDay =  NSLayoutConstraint(item: dayLabel!, attribute: .Top, relatedBy: .Equal,
            toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 7.5)
        /*let toBottomDay =  NSLayoutConstraint(item: dayLabel!, attribute: .Bottom, relatedBy: .Equal,
            toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -5)*/
        let leadingMarginDay =  NSLayoutConstraint(item: dayLabel!, attribute: .LeadingMargin, relatedBy: .Equal,
            toItem: contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 5)
        dayLabel!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([toTopDay, leadingMarginDay])
        
        //create minmum temperature label
        temperatureLow!.font = font
        temperatureLow!.backgroundColor = UIColor.clearColor()
        temperatureLow!.textColor = UIColor.whiteColor()
        temperatureLow!.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(temperatureLow!)
        let toTopTL =  NSLayoutConstraint(item: temperatureLow!, attribute: .Top, relatedBy: .Equal,
            toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 7.5)
        /*let toBottomTL =  NSLayoutConstraint(item: temperatureLow!, attribute: .Bottom, relatedBy: .Equal,
            toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -5)*/
        let trailingTL =  NSLayoutConstraint(item: temperatureLow!, attribute: .TrailingMargin, relatedBy: .Equal,
            toItem: contentView, attribute: .TrailingMargin, multiplier: 1.0, constant: -2)
        temperatureLow!.translatesAutoresizingMaskIntoConstraints = false
        //NSLayoutConstraint.activateConstraints([toTopTL, toBottomTL, trailingTL])
        NSLayoutConstraint.activateConstraints([toTopTL, trailingTL])
        
        // create temperature high
        temperatureHigh!.font = font
        temperatureHigh!.backgroundColor = UIColor.clearColor()
        temperatureHigh!.textColor = UIColor.whiteColor()
        temperatureHigh!.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(temperatureHigh!)
        let toTopTH =  NSLayoutConstraint(item: temperatureHigh!, attribute: .Top, relatedBy: .Equal,
            toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 7.5)
       /* let toBottomTH =  NSLayoutConstraint(item: temperatureHigh!, attribute: .Bottom, relatedBy: .Equal,
            toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -5)*/
        let trailingTH =  NSLayoutConstraint(item: temperatureHigh!, attribute: .TrailingMargin, relatedBy: .Equal,
            toItem: contentView, attribute: .TrailingMargin, multiplier: 1.0, constant: -60)
        temperatureHigh!.translatesAutoresizingMaskIntoConstraints = false
        //NSLayoutConstraint.activateConstraints([toTopTH, toBottomTH, trailingTH])
        NSLayoutConstraint.activateConstraints([toTopTH, trailingTH])
        
        
        //add weather icon label
        weatherIconLabel!.font = font
        weatherIconLabel!.backgroundColor = UIColor.clearColor()
        weatherIconLabel!.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(weatherIconLabel!)
        weatherIconLabel!.hidden = true
        
        //add weather icon
        weatherIcon!.image = UIImage(named: "\(weatherIconLabel!.text)")
        self.contentView.addSubview(weatherIcon!)
        let toTopWI =  NSLayoutConstraint(item: weatherIcon!, attribute: .Top, relatedBy: .Equal,
            toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 5)
        let toBottomWI =  NSLayoutConstraint(item: weatherIcon!, attribute: .Bottom, relatedBy: .Equal,
            toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -5)
        let leadingWI = NSLayoutConstraint(item: weatherIcon!, attribute: .LeadingMargin, relatedBy: .Equal,
            toItem: contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: self.frame.width/2)
        /*let heightWI = NSLayoutConstraint(item: weatherIcon!, attribute: .Height, relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)*/
        let widthWI = NSLayoutConstraint(item: weatherIcon!, attribute: .Width, relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)
        weatherIcon!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([toTopWI, toBottomWI, leadingWI, widthWI])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
