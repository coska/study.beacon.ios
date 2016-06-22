//
//  BeaconDetailViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

enum BeaconDetailMode
{
    case Add
    case Edit
}

class BeaconDetailViewController: UIViewController
{
    let kCellIdentifier = "beaconCell"
    var detailMode: BeaconDetailMode?
    
    lazy var fakeDataSource: Array<String> =
    {
        return ["In progress"]
    }()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

        if self.detailMode == .Add
        {
            self.title = "Add Beacon"
            self.navigationItem.rightBarButtonItem = nil
            self.deleteButton.hidden = true
        }
        else
        {
            self.title = "Edit Beacon"
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Event handler
    
    @IBAction func cancelButtonTapped(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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

}
