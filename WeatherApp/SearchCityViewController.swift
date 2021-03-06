//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/3/4.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit
import CoreLocation

class SearchCityViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate, UIActionSheetDelegate {
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
      
       self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBOutlet weak var searchCityName: UISearchBar!
    var viewModel: WeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchCityName!.delegate = self

        // Do any additional setup after loading the view.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchCityName: UISearchBar) {
        var cityName: String?
        searchCityName.resignFirstResponder()
 
        
        DataManager.getLocationFromGoogle(searchCityName.text!, success: {(LocationData) -> Void in
        
            let json = JSON(data: LocationData)
            if json["status"] == "OK" {
                let longitudeX = json["results"][0]["geometry"]["location"]["lng"].double!
                let latitudeY = json["results"][0]["geometry"]["location"]["lat"].double!
                let cityLocation: CLLocation =  CLLocation(latitude: latitudeY, longitude: longitudeX)
                
                cityName = json["results"][0]["address_components"][0]["long_name"].string
                dispatch_async(dispatch_get_main_queue()) {
                    self.viewModel?.searchCityLocation(cityName!,location: cityLocation)
                }
                self.dismissViewControllerAnimated(true, completion: nil)
           } else {
               dispatch_async(dispatch_get_main_queue()) {
               let myAlert = UIAlertController(title: nil, message: "Address not found", preferredStyle: .Alert)
               let action = UIAlertAction(
                  title: "OK",
                style: .Default, handler: nil)
                myAlert.addAction(action)
           self.presentViewController(myAlert, animated: true, completion: nil)
           }
         }
      })
        
        
        
    }

}
