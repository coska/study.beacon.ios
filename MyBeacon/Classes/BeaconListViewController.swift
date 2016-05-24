//
//  BeaconListViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class BeaconListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let kCellIdentifier = "beaconCell"
    weak var delegate: HomeListDelegate?

    lazy var fakeDataSource: Array<String> =
    {
        return ["Beacon 1", "Beacon 2", "Beacon 3"]
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
 
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.fakeDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = self.fakeDataSource[indexPath.row]
        
        return cell;
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // tk (test)
        // let storyboard = UIStoryboard(name: "TaskRule", bundle: nil)
        
        //let beaconDetailViewController = storyboard.instantiateViewControllerWithIdentifier("BeaconDetailViewController") as! BeaconDetailViewController
        //beaconDetailViewController.detailMode = .Edit
        
        // Mock Data
        let orgBeacon = Beacon()
        orgBeacon.id = "F94DBB23-2266-7822-3782-57BEAC0952AC"
        orgBeacon.major = 51320
        orgBeacon.minor = 45042
        orgBeacon.name = "0117C55A175E"
        //beaconDetailViewController.updatedBeacon() //.updateBeacon(orgBeacon)
        
        //self.delegate?.willPushViewController(beaconDetailViewController, animated: true)
    }
}
