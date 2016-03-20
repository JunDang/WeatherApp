//
//  SideBarTableViewController.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/16.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit



class SideBarTableViewController: UITableViewController, UINavigationBarDelegate{
    var delegate: UITableViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.registerNib(UINib(nibName: "TemperatureUnitsSegment", bundle: nil), forCellReuseIdentifier: "TemperatureUnitsSegmentCell")
        tableView!.registerNib(UINib(nibName: "WindSpeedUnitCell", bundle: nil), forCellReuseIdentifier: "WindSpeedUnitCell")

       
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView!.backgroundColor = UIColor.clearColor()
        tableView!.frame = CGRectMake(0, self.view.bounds.origin.y + 100, self.view.bounds.width, self.view.bounds.height/2)
        tableView!.delegate = self
        tableView!.pagingEnabled = true
        tableView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if (indexPath.row == 0) {
            let cell: TemperatureUnitsSegment = tableView.dequeueReusableCellWithIdentifier("TemperatureUnitsSegmentCell", forIndexPath: indexPath) as! TemperatureUnitsSegment
            //cell.textLabel!.text = "I LOVE YOU"
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            return cell
            
        } else if (indexPath.row == 1){
            let cell: WindSpeedUnitCell = tableView.dequeueReusableCellWithIdentifier("WindSpeedUnitCell", forIndexPath: indexPath) as! WindSpeedUnitCell
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            return cell
        }
        
       
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
   /* override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sideBarControlDidSelectRow(indexPath)
    }*/
    
}
