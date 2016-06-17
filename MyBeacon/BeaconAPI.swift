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
        return ["F94DBB23-2266-7822-3782-57BEAC0952AC", // BeaconStac
                "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5", // Air Locate
                "F0018B9B-7509-4C31-A905-1A27D39C003C", // Beacon Inside
                "44F77920-EBF9-11E3-AC10-0800200C9A66", // Robin
                "AA6062F0-98CA-4211-8EC4-193EB73CEBE6", // Open Beacon
                "B9407F30-F5F8-466E-AFF9-25556B57FE6D", // Estimote
                "F7826DA6-4FA2-4E98-8024-BC5B71E0893E", // Kontakt.io
                "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", // Radius Networks
                "8DEEFBB9-F738-4297-8040-96668BB44281", // Roximity
                "acfd065e-c3c0-11e3-9bbe-1a514932ac01", // BlueBeacon
                "74278BDA-B644-4520-8F0C-720EAF059935", // Glimworm
                "61687109-905F-4436-91F8-E602F514C96D", // Bluecats
                "19D5F76A-FD04-5AA3-B16E-E93277163AF6", // Passkit
                "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", // Bleu Station
                "EBEFD083-70A2-47C8-9837-E7B5634DF524", // EasiBeacon
                "B0702980-A295-A8AB-F734-031A98A512DE"  // RedBear
                                                        // Gimbal
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
    weak var beaconProtocol: BeaconProtocol?
    
    // MARK: Public Functions
    func startSearchingBeacons() {        
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
    
    func stopSearchingBeacons() {
        if let beacon = self.beacon {
            guard let uuid = NSUUID(UUIDString: beacon.id) else { return }
            let major: CLBeaconMajorValue = UInt16(beacon.major)
            let minor: CLBeaconMajorValue = UInt16(beacon.minor)
            let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: beacon.name)
            
            locationManager.stopMonitoringForRegion(region)
            locationManager.stopRangingBeaconsInRegion(region)
        } else {
            for strUUID in supportedUUIDs {
                guard let uuid = NSUUID(UUIDString: strUUID) else { return }
                let region = CLBeaconRegion(proximityUUID: uuid, identifier: strUUID)
                locationManager.stopMonitoringForRegion(region)
                locationManager.stopRangingBeaconsInRegion(region)
            }
        }
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