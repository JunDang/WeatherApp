//
//  SearchCity.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/4.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

class SearchCity: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate, UIActionSheetDelegate {

    @IBOutlet weak var searchCityName: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func searchBarSearchButtonClicked(searchCityName: UISearchBar) {
        searchCityName.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        
        DataManager.getLocationFromGoogle(searchCityName.text!, success: {(LocationData) -> Void in
            let json = JSON(data: LocationData)
            if json["status"] != "ZERO_RESULTS" {
                let longitudeX = json["results"][0]["geometry"]["location"]["lng"].double!
                let latitudeY = json["results"][0]["geometry"]["location"]["lat"].double!
                let coordinate = CLLocationCoordinate2DMake(latitudeY, longitudeX)
                dispatch_async(dispatch_get_main_queue()) {
                    WeatherViewModel.locationDidUpdate()
                    
                }
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
