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
        
        self.title = "Add Beacon"
        
        initializeTableView()

        startSearchBeacons()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopSearchBeacons()
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

    private func initializeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.registerNib(UINib(nibName: kBeaconAddListCell, bundle: nil), forCellReuseIdentifier: kBeaconAddListCell)
    }
    
    private func startSearchBeacons() {
        BeaconAPI.sharedInstance.beaconProtocol = self
        BeaconAPI.sharedInstance.startSearchingBeacons()
    }
    
    private func stopSearchBeacons() {
        BeaconAPI.sharedInstance.stopSearchingBeacons()
    }
    
    // MARK: - Actions
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }    
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
                // TODO: read Beacon from DB, and append if it's not in DB
                let allBeacons: [Beacon] = Beacon.loadAll()
                let result = allBeacons.filter { $0.id == beacon.proximityUUID.UUIDString }
                if result.count == 0 {
                    self.beacons.append(beacon)
                    tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.beacons.count-1, inSection: 0)], withRowAnimation: .Top)
                } else {
                    print("This beacon (\(beacon.proximityUUID.UUIDString)) is already added.")
                }
            } else {
                let index  = self.beacons.indexOf { $0.proximityUUID == beacon.proximityUUID }
                if index != nil {
                    self.beacons[index!] = beacon
                    
                    let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index!, inSection: 0)) as! BeaconAddListCell
                    cell.beacon = beacon
                }
            }
        }
    }
}

extension BeaconAddViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kBeaconAddListCell, forIndexPath: indexPath) as! BeaconAddListCell
        cell.beacon = beacons[indexPath.row] as CLBeacon
        return cell
    }
}

extension BeaconAddViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let addedBeacon = beacons[indexPath.row] as CLBeacon
        let beacon = Beacon()
        beacon.id = addedBeacon.proximityUUID.UUIDString
        beacon.major = addedBeacon.major.integerValue
        beacon.minor = addedBeacon.minor.integerValue
        beacon.name = addedBeacon.proximityUUID.UUIDString
        Beacon.save(beacon)
        
        beacons.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}