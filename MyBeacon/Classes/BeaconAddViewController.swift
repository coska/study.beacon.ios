//
//  BeaconAddViewController.swift
//  MyBeacon
//
//  Created by Dexter Kim on 2016-05-15.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconAddViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let kBeaconAddListCell = "BeaconAddListCell"
    private var beacons: [CLBeacon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: kBeaconAddListCell, bundle: nil), forCellReuseIdentifier: kBeaconAddListCell)

        BeaconAPI.sharedInstance.beaconProtocol = self
        BeaconAPI.sharedInstance.startSearchingBeacon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BeaconAddViewController: BeaconProtocol {
    // MARK: - BeaconDataSource
    func updatedBeacon() -> Beacon? {
        return nil
    }
    
    // MARK: - BeaconDelegate
    func beaconAPI(beaconAPI: BeaconAPI, didEnterRegion region: CLRegion) {
        print("didEnterRegion: \(region.identifier)")
    }
    
    func beaconAPI(beaconAPI: BeaconAPI, didExitRegion region: CLRegion) {
        print("didExitRegion: \(region.identifier)")
    }
    
    func beaconAPI(beaconAPI: BeaconAPI, didRangeBeacon beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        for beacon in beacons {            
            print("Proximity: \(beacon.proximity.Desc()), RSSI: \(beacon.rssi)db")
            
            let result = self.beacons.filter { $0.proximityUUID == beacon.proximityUUID }            
            if result.count == 0 {
                self.beacons.append(beacon)
                
            } else {
                let index  = self.beacons.indexOf { $0.proximityUUID == beacon.proximityUUID }
                if index != nil {
                    self.beacons[index!] = beacon
                }
            }
        }
        
        tableView.reloadData()
    }
}

extension BeaconAddViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kBeaconAddListCell, forIndexPath: indexPath) as! BeaconAddListCell
        let beacon = beacons[indexPath.row] as CLBeacon
        cell.textLabel?.text = beacon.proximityUUID.UUIDString
        
        let detailText = "Proximity: \(beacon.proximity.Desc()), RSSI: \(beacon.rssi)db"
        cell.detailTextLabel?.text = detailText
        
        return cell
    }
}

extension BeaconAddViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}