//
//  SideBarTableViewController.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/3/16.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

/*protocol SideBarTableViewControllerDelegate{
    func sideBarControlDidSelectRow(indexPath:NSIndexPath)
}*/

class SideBarTableViewController: UITableViewController{
    var delegate: UITableViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.registerNib(UINib(nibName: "TemperatureUnitsSegment", bundle: nil), forCellReuseIdentifier: "TemperatureUnitsSegmentCell")
        tableView!.registerNib(UINib(nibName: "WindSpeedUnitCell", bundle: nil), forCellReuseIdentifier: "WindSpeedUnitCell")

        //tableView!.registerClass(TemperatureUnitsSegment.self, forCellReuseIdentifier: "TemperatureUnitsSegmentCell")
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView!.backgroundColor = UIColor.clearColor()
        print("6")// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            return cell
            
        } else if (indexPath.row == 1){
            let cell: WindSpeedUnitCell = tableView.dequeueReusableCellWithIdentifier("WindSpeedUnitCell", forIndexPath: indexPath) as! WindSpeedUnitCell
            cell.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.3)
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.3)
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
