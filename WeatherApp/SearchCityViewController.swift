//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/4.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit
import CoreLocation

class SearchCityViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate, UIActionSheetDelegate {
    
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
        print("searchbarcalled")
        searchCityName.resignFirstResponder()
 
        
        DataManager.getLocationFromGoogle(searchCityName.text!, success: {(LocationData) -> Void in
        
            let json = JSON(data: LocationData)
            if json["status"] != "ZERO_RESULTS" {
                let longitudeX = json["results"][0]["geometry"]["location"]["lng"].double!
                let latitudeY = json["results"][0]["geometry"]["location"]["lat"].double!
                let cityLocation: CLLocation =  CLLocation(latitude: latitudeY, longitude: longitudeX)
                print("cityLocation: \(cityLocation)")
                dispatch_async(dispatch_get_main_queue()) {
                    print("cityLocation: \(cityLocation)")
                    //let weatherViewModel = WeatherViewModel()
                    //weatherViewModel.startLocationService()
                    //self.weatherViewModel.searchCityLocation(cityLocation)
                    self.viewModel?.searchCityLocation(cityLocation)
        
                }
                self.dismissViewControllerAnimated(true, completion: nil)
           } else {
               dispatch_async(dispatch_get_main_queue()) {
               let myAlert = UIAlertController(title: nil, message: "Address not found", preferredStyle: .Alert)
               let action = UIAlertAction(
                  title: "OK",
                  style: .Default) { action in self.dismissViewControllerAnimated(true, completion: nil)
           }
           myAlert.addAction(action)
           self.presentViewController(myAlert, animated: true, completion: nil)
           }
         }
      })
        
        
        
    }

}
