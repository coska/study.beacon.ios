//
//  BeaconDetailViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit
import CoreLocation

enum BeaconDetailMode
{
    case Add
    case Edit
}

enum DetailMainRows: Int {
    case UUID = 0
    case Major
    case Minor
    
    static let count = Minor.rawValue + 1
}

enum SectionInfo: Int {
    case Name = 0
    case DetailMain
    case DetailExtra
    
    var numOfRows: Int {
        switch self {
        case .Name: return 1
        case .DetailMain: return DetailMainRows.count
        case .DetailExtra: return 2
        }
    }
    
    var title: String {
        switch self {
        case .Name: return "Beacon Name"
        case .DetailMain: return "Device Detail"
        case .DetailExtra: return "Addtional Information"
        }
    }
    
    static let count = DetailExtra.rawValue + 1
}

class BeaconDetailViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    let kCellIdentifier = "beaconCell"
    var detailMode: BeaconDetailMode = .Add
    var orgBeacon: Beacon?
    var newBeacon: Beacon?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if self.detailMode == .Add
        {
            self.title = "Add Beacon"
            self.deleteButton.hidden = true
        }
        else
        {
            self.title = "Edit Beacon"
            
            BeaconAPI.sharedInstance.beaconProtocol = self
            BeaconAPI.sharedInstance.startSearchingBeacon()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Event handler
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        switch detailMode {
        case .Add:
            self.dismissViewControllerAnimated(true, completion: nil)
        case .Edit:
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject)
    {
        // Save updated Beacon
        if let newBeacon = newBeacon {
            Beacon.save(newBeacon)
        } else {
            print("Couldn't save the updated beacon because it's nil")
        }
        
        switch detailMode {
        case .Add:
            self.dismissViewControllerAnimated(true, completion: nil)
        case .Edit:
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: Private Functions
    func updateBeacon(beacon: Beacon) {
        
        tableView.reloadData()
    }
}

extension BeaconDetailViewController: UITableViewDataSource {
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionInfo.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = SectionInfo(rawValue: section) else {
            return ""
        }
        
        return sectionInfo.title
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension BeaconDetailViewController: UITableViewDelegate {
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = SectionInfo(rawValue: section) else {
            return 0
        }
        
        return sectionInfo.numOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath)
        
        return cell
    }
}

extension BeaconDetailViewController: BeaconProtocol {
    // MARK: BeaconDataSource
    func updatedBeacon() -> Beacon? {
        return detailMode == .Add ? nil : orgBeacon
    }
    
    // MARK: BeaconDelegate
    func beaconAPI(beaconAPI: BeaconAPI, didEnterRegion region: CLRegion) {
        
    }
    
    func beaconAPI(beaconAPI: BeaconAPI, didExitRegion region: CLRegion) {
        
    }
    
    func beaconAPI(beaconAPI: BeaconAPI, didRangeBeacon beacon: CLBeacon, inRegion: CLBeaconRegion) {

    }
}
