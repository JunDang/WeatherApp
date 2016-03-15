//
//  FlickrPhoto.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/2/6.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhoto {
    
    let photoID: String
    let farm: Int
    let secret: String
    let server: String
    
    init (photoID:String,farm:Int, server:String, secret:String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func flickrImageURL(size:String = "b") -> NSURL {
        return NSURL(string: "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!
    }
    
   
    
    
}
