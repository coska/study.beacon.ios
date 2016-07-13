//
//  AppDelegate.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static private let TASK_NOT_SELECTED:Int = -1
    
    var window: UIWindow?
    var locationManager: CLLocationManager?
    
    static var tasks:[Task] = Database.loadAll(Task.self)
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupLocationManager()
        startMonitoringRegionForTaskBeacons()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        startMonitoringRegionForTaskBeacons()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        let notificationSetting = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSetting)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    func startMonitoringRegionForTaskBeacons()
    {
        var beacons: [Beacon] = []
        
        for task in AppDelegate.tasks {
            for beacon in task.beacons {
                if beacons.contains(beacon) == false {
                    beacons.append(beacon)
                }
            }
        }
        
        for beacon in beacons {
            if let uuid = NSUUID(UUIDString: beacon.id) {
                let major: CLBeaconMajorValue = UInt16(Int(beacon.major))
                let minor: CLBeaconMajorValue = UInt16(Int(beacon.minor))
                let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: beacon.id)
                region.notifyEntryStateOnDisplay = true
                locationManager?.stopMonitoringForRegion(region)
                locationManager?.startMonitoringForRegion(region)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("\(#function)")
        
        let filteredBeacons = Database.loadAll(Beacon.self).filter { $0.id == region.identifier }
        if filteredBeacons.count > 0 {
            let results = AppDelegate.tasks.filter { $0.isApplicable(manager.location!) == true }
//            let results = AppDelegate.tasks.filter { $0.beacons.contains(filteredBeacons.first!) && $0.actions.count>0 }
            for task in results {
                if let action = task.actions.first {
                    switch action.type {
                    case ActionType.Text.rawValue:
                        let arr = action.value.componentsSeparatedByString("|")
                        sendText(arr[0], msg: arr[1])
                    case ActionType.Call.rawValue:
                        callNumber(action.value)
                    case ActionType.Wifi.rawValue:
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("\(#function)")
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        
        let notification: UILocalNotification = UILocalNotification()

        if (state == .Inside) {
            notification.alertBody = "You are inside region \(region.identifier)";
        } else if (state == .Outside) {
            notification.alertBody = "You are outside region \(region.identifier)";
        } else {
            return;
        }
        
        print(notification.alertBody)
        
//        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    private func callNumber(phoneNo:String) {
        if let url:NSURL = NSURL(string:"telprompt://\(phoneNo.stringByReplacingOccurrencesOfString(" ", withString: ""))") {
            let app:UIApplication = UIApplication.sharedApplication()
            if (app.canOpenURL(url)) {
                app.openURL(url);
            }
        }
    }
    
    private func sendText(phoneNo:String, msg:String) {
        if let url:NSURL = NSURL(string:"sms://\(phoneNo)") {
            let app:UIApplication = UIApplication.sharedApplication()
            if (app.canOpenURL(url)) {
                app.openURL(url);
            }
        }
        
    }
}

