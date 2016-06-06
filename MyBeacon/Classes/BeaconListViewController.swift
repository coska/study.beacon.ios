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

    lazy var fakeDataSource: Array<String> =
    {
        return [
            "BeaconStac",
            "Air Locate",
            "Beacon Inside",
            "Robin",
            "Open Beacon",
            "Estimote",
            "Kontakt.io",
            "Radius Networks",
            "Roximity",
            "BlueBeacon",
            "Glimworm",
            "Bluecats",
            "Passkit",
            "Bleu Station",
            "EasiBeacon",
            "RedBear"
            // Gimbal
        ]
    }()
    
    lazy var fakeImageSource: Array<String> =
    {
       return [
        "F94DBB23-2266-7822-3782-57BEAC0952AC.png", // BeaconStac
        "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5.png", // Air Locate
        "F0018B9B-7509-4C31-A905-1A27D39C003C.png", // Beacon Inside
        "44F77920-EBF9-11E3-AC10-0800200C9A66.png", // Robin
        "AA6062F0-98CA-4211-8EC4-193EB73CEBE6.png", // Open Beacon
        "B9407F30-F5F8-466E-AFF9-25556B57FE6D.png", // Estimote
        "F7826DA6-4FA2-4E98-8024-BC5B71E0893E.png", // Kontakt.io
        "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6.png", // Radius Networks
        "8DEEFBB9-F738-4297-8040-96668BB44281.png", // Roximity
        "acfd065e-c3c0-11e3-9bbe-1a514932ac01.png", // BlueBeacon
        "74278BDA-B644-4520-8F0C-720EAF059935.png", // Glimworm
        "61687109-905F-4436-91F8-E602F514C96D.png", // Bluecats
        "19D5F76A-FD04-5AA3-B16E-E93277163AF6.png", // Passkit
        "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0.png", // Bleu Station
        "EBEFD083-70A2-47C8-9837-E7B5634DF524.png", // EasiBeacon
        "B0702980-A295-A8AB-F734-031A98A512DE.png"  // RedBear
                                                    // Gimbal
        ]
    }()
    
    lazy var fakeUUIDSource: Array<String> =
    {
        return [
            "F94DBB23-2266-7822-3782-57BEAC0952AC", // BeaconStac
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
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! BeaconCustomTableViewCell
        
        // Square Image to Circle Image - beaconImage
        cell.beaconImage.layer.cornerRadius = cell.beaconImage.frame.width / 2
        cell.beaconImage.clipsToBounds = true
        
        // fakeDatas to the Cell as DEMO
        cell.beaconNameLabel?.text = self.fakeDataSource[indexPath.row]
        cell.beaconImage?.image = UIImage(named: fakeImageSource[indexPath.row])
        cell.beaconUUIDLabel?.text = self.fakeUUIDSource[indexPath.row]
        
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            fakeDataSource.removeAtIndex(indexPath.row)
            fakeImageSource.removeAtIndex(indexPath.row)
            fakeUUIDSource.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let beaconDetailViewController = storyboard.instantiateViewControllerWithIdentifier("BeaconDetailViewController") as! BeaconDetailViewController
        
        // Mock Data
        let orgBeacon = Beacon()
        orgBeacon.id = "F94DBB23-2266-7822-3782-57BEAC0952AC"
        orgBeacon.major = 51320
        orgBeacon.minor = 45042
        orgBeacon.name = "0117C55A175E"
        beaconDetailViewController.selectedBeacon(orgBeacon)
        
        self.delegate?.willPushViewController(beaconDetailViewController, animated: true)
    }
}
