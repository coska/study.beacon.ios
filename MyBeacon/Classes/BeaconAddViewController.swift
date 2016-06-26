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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BeaconAddViewController.didEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: UIApplication.sharedApplication())
        
        startPulsingHaloAnimation()
        startSearchBeacons()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopSearchBeacons()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        stopPulsingHaloAnimation()
        startPulsingHaloAnimation(CGPointMake(size.width/2, size.height/2))
    }
    
    func didEnterForeground(notification: NSNotification) {
        startPulsingHaloAnimation()
    }
    
    private func startPulsingHaloAnimation() {
        startPulsingHaloAnimation(view.center)
    }
    private func startPulsingHaloAnimation(center: CGPoint) {
        let halo = PulsingHaloLayer()
        var bottom: CGPoint = center
        bottom.y = bottom.y + 66
        halo.position = bottom
        self.view.layer.insertSublayer(halo, atIndex: 0)
        
        halo.haloLayerNumber = 6
        halo.radius = self.view.bounds.width * 2 / 3
        halo.animationDuration = 6.0
        halo.pulseInterval = 0.8
        halo.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.5, blue: 0.7, alpha: 0.9).CGColor
        
        halo.start()
    }
    
    private func stopPulsingHaloAnimation() {
        self.view.layer.sublayers?.first?.removeFromSuperlayer()
    }

    private func initializeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clearColor()

        tableView.registerNib(UINib(nibName: kBeaconAddListCell, bundle: nil), forCellReuseIdentifier: kBeaconAddListCell)
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            let blurEffect = UIBlurEffect(style: .Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView            
            tableView.separatorEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        }
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
                let allBeacons: [Beacon] = Database.loadAll(Beacon.self)
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
                
                    if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index!, inSection: 0)) {
                        (cell as! BeaconAddListCell).beacon = beacon
                    }
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
        Database.save(beacon)
        
        beacons.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}