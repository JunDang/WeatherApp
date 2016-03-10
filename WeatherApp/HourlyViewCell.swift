//
//  HourlyViewCell.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/23.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

class HourlyViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    var hourlyForecasts: [HourlyForecast] = [HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "1"),
        HourlyForecast(time: "9:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "10:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "11:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0"),
        HourlyForecast(time: "8:00", iconName: "weather-snow", temperature: "0")
        
    ]


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        let width = WeatherViewController().screenWidth
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.5
        layout.estimatedItemSize = CGSize(width: width, height: 30.0)
        collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(TodayWeaterCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        collectionView.setNeedsDisplay()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(collectionView)
        let toTop =  NSLayoutConstraint(item: collectionView, attribute: .Top, relatedBy: .Equal,
            toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 1)
        let toBottom =  NSLayoutConstraint(item: collectionView, attribute: .Bottom, relatedBy: .Equal,
            toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -1)
        let leadingMargin = NSLayoutConstraint(item: collectionView, attribute: .LeadingMargin, relatedBy: .Equal,
            toItem: contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 2)
        let heightConstraint = NSLayoutConstraint(item: collectionView,
            attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1, constant: 90)
        //to avoid the "UIView-Encapsulated-Layout-Height constraint" error
        heightConstraint.priority = 999
        let widthConstraint = NSLayoutConstraint(item: collectionView,
            attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1, constant: width)
        //print("HourlyViewCell: \(toBottom)")
   
        NSLayoutConstraint.activateConstraints([toTop, toBottom, heightConstraint,leadingMargin,
            widthConstraint])
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: TodayWeaterCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! TodayWeaterCollectionViewCell
        //let hourlyForecast = hourlyForecasts[indexPath.row]
        if indexPath.row == 0 {
            cell.labelTime!.text = "Now"
            cell.labelTemperature?.text = hourlyForecasts[0].temperature
            cell.iconLabel!.text = hourlyForecasts[0].iconName
            cell.weatherIcon!.image = UIImage(named: "\(cell.iconLabel!.text!)")
        } else {
                let hourlyForecast = hourlyForecasts[indexPath.row]
                cell.labelTime!.text = hourlyForecast.time
                cell.labelTemperature?.text = hourlyForecast.temperature
                cell.iconLabel!.text = hourlyForecast.iconName
                cell.weatherIcon!.image = UIImage(named: "\(cell.iconLabel!.text!)")
        
        }
        
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(30, 90)
    }
    
    func updateWeatherData(hourlyForecasts: [HourlyForecast]){
        guard hourlyForecasts.count > 0 else {
            return
        }
        self.hourlyForecasts = hourlyForecasts
        self.collectionView.reloadData()
        
    }


}
