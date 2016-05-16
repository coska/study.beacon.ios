//
//  BeaconAPI.swift
//  Beacon
//
//  Created by Dexter Kim on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import Foundation
import CoreLocation

typealias BeaconProtocol = protocol<BeaconDataSource, BeaconDelegate>

protocol BeaconDataSource {
    func updatedBeacon() -> Beacon?
}

@objc protocol BeaconDelegate {
    func beaconAPI(beaconAPI: BeaconAPI, didEnterRegion region: CLRegion)
    func beaconAPI(beaconAPI: BeaconAPI, didExitRegion region: CLRegion)
    func beaconAPI(beaconAPI: BeaconAPI, didRangeBeacon beacons: [CLBeacon], inRegion region: CLBeaconRegion)
}

class BeaconAPI: NSObject {
    
    // MARK: - Singleton Instance
    static let sharedInstance = BeaconAPI()
    
    // MARK: - Privates
    private var supportedUUIDs: [String] {
        return ["F94DBB23-2266-7822-3782-57BEAC0952AC",
                "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0",
                "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5",
                "74278BDA-B644-4520-8F0C-720EAF059935",
                "F0018B9B-7509-4C31-A905-1A27D39C003C",
                "44F77920-EBF9-11E3-AC10-0800200C9A66",
                "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        ]
    }
    private lazy var locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
    private var beacon: Beacon?
    
    // MARK: - Publics
    var beaconProtocol: BeaconProtocol?
    
    // MARK: Public Functions
    func startSearchingBeacon() {
        stopSearchingBeacon()
        
        beacon = beaconProtocol?.updatedBeacon()
        
        if let beacon = self.beacon {
            guard let uuid = NSUUID(UUIDString: beacon.id) else { return }
            let major: CLBeaconMajorValue = UInt16(Int(beacon.major))
            let minor: CLBeaconMajorValue = UInt16(Int(beacon.minor))
            let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: beacon.id)
            
            locationManager.startMonitoringForRegion(region)
            locationManager.startRangingBeaconsInRegion(region)
        } else {
            // search up all the beacon devices compatible with iBeacon
            for strUUID in supportedUUIDs {
                guard let uuid = NSUUID(UUIDString: strUUID) else { return }
                let region = CLBeaconRegion(proximityUUID: uuid, identifier: strUUID)
                locationManager.startMonitoringForRegion(region)
                locationManager.startRangingBeaconsInRegion(region)
            }
        }
    }
    
    func stopSearchingBeacon() {
        guard let beacon = self.beacon else { return }
        guard let uuid = NSUUID(UUIDString: beacon.id) else { return }
        let major: CLBeaconMajorValue = UInt16(beacon.major)
        let minor: CLBeaconMajorValue = UInt16(beacon.minor)
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: beacon.name)
        
        locationManager.stopMonitoringForRegion(region)
        locationManager.stopRangingBeaconsInRegion(region)
    }
}

extension BeaconAPI: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("Ready to Start monitoring ...")
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.beaconProtocol?.beaconAPI(self, didEnterRegion: region)
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.beaconProtocol?.beaconAPI(self, didEnterRegion: region)
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring region: \(error.description)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager failed: \(error.description)")
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        print("didRangeBeacons: \(beacons)")
        
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        
        if (knownBeacons.count > 0) {
            self.beaconProtocol?.beaconAPI(self, didRangeBeacon: knownBeacons, inRegion: region)
        } else {
            print("Couldn't find any Beacons. Please check out the detail information of Beacon.")
        }
    }
}