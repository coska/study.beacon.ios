//
//  BeaconListViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class BeaconListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let kCellIdentifier = "beaconCell"
    weak var delegate: HomeListDelegate?
    
    var beacons: [Beacon] = Database.loadAll(Beacon)
    var supportedUUIDs: [String] {
        return BeaconAPI.sharedInstance.supportedUUIDs
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        beacons = Database.loadAll(Beacon)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateBeaconList() {
        Database.sharedInstance.refresh()
        self.beacons = Database.loadAll(Beacon)
        self.tableView.reloadData()
    }
 
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! BeaconCustomTableViewCell
        
        // Square Image to Circle Image - beaconImage
        cell.beaconImage.layer.cornerRadius = cell.beaconImage.frame.width / 2
        cell.beaconImage.clipsToBounds = true
        
        let beacon = beacons[indexPath.row]
        cell.beaconNameLabel?.text =  beacon.name
        cell.beaconImage?.image = UIImage(named: supportedUUIDs[indexPath.row%3])
        cell.beaconUUIDLabel?.text = beacon.id
        
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let beacon = beacons[indexPath.row]
            Database.delete(beacon)
            self.beacons.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "BeaconDetail", bundle: nil)
        let nav = storyboard.instantiateViewControllerWithIdentifier("BeaconDetailNavigation") as! UINavigationController
        guard let beaconDetailViewController = nav.topViewController as? BeaconDetailViewController else { return }
        
        let beacon = beacons[indexPath.row]
        let results = Database.sharedInstance.objects(Beacon).filter("id = %@", beacon.id)

        let orgBeacon: Beacon = results[0]
        beaconDetailViewController.selectedBeacon(orgBeacon)
        beaconDetailViewController.beaconImageName = supportedUUIDs[indexPath.row]
        
        self.delegate?.willPushViewController(beaconDetailViewController, animated: true)
    }
}
