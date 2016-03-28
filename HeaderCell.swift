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
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
