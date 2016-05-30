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

    var fakeImageSource: [String] {
       return ["canada.png", "germany.png", "uk.png"]
    }
    
    var beacons: [Beacon] = Database.loadAll(Beacon)
    
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
 
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! BeaconCustomTableViewCell
        
        // Square Image to Circle Image - beaconImage
        cell.beaconImage.layer.cornerRadius = cell.beaconImage.frame.width / 2
        cell.beaconImage.clipsToBounds = true
        
        // fakeDatas to the Cell as DEMO
        let beacon = beacons[indexPath.row]
        cell.beaconNameLabel?.text =  beacon.name
        cell.beaconImage?.image = UIImage(named: fakeImageSource[indexPath.row%3])
        cell.beaconUUIDLabel?.text = beacon.id
        
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let beacon = beacons[indexPath.row]
            Database.delete(beacon)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "BeaconDetail", bundle: nil)
        let beaconDetailViewController = storyboard.instantiateViewControllerWithIdentifier("BeaconDetailViewController") as! BeaconDetailViewController
        
        // Mock Data
        let beacon = beacons[indexPath.row]
        let results = Database.sharedInstance.objects(Beacon).filter("id = %@", beacon.id)

        let orgBeacon: Beacon = results[0]
        beaconDetailViewController.selectedBeacon(orgBeacon)
        beaconDetailViewController.beaconImageName = fakeImageSource[indexPath.row%3]
        
        self.delegate?.willPushViewController(beaconDetailViewController, animated: true)
    }
}
