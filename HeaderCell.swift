//
//  HeaderCell.swift
//  WeatherApp
//

//  Created by Jun Dang on 16/2/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.

import UIKit

class HeaderCell: UITableViewCell {
    
    let headerTitle: UILabel? = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        let font = UIFont(name: "Arial", size: 20.0)
        headerTitle!.font = font
        headerTitle!.backgroundColor = UIColor.clearColor()
        headerTitle!.textAlignment = NSTextAlignment.Left
        headerTitle!.text = ""
        self.contentView.addSubview(headerTitle!)
        /*let toTopHeader =  NSLayoutConstraint(item: headerTitle!, attribute: .Top, relatedBy: .Equal,
            toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 2)
        let toBottomHeader =  NSLayoutConstraint(item: headerTitle!, attribute: .Bottom, relatedBy: .Equal,
            toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -2)
        let leadingHeader =  NSLayoutConstraint(item: headerTitle!, attribute: .LeadingMargin, relatedBy: .Equal,
            toItem: contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 5)
        headerTitle!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([toTopHeader, toBottomHeader, leadingHeader])*/
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
