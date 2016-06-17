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

enum NameRows: Int {
    case Name = 0
    
    static let count = Name.rawValue + 1
    
    var Desc: String {
        switch self {
        case .Name: return "Name"
        }
    }
}

enum DetailMainRows: Int {
    case UUID = 0
    case Major
    case Minor
    
    static let count = Minor.rawValue + 1
    
    var Desc: String {
        switch self {
        case .UUID: return "UUID"
        case .Major: return "Major"
        case .Minor: return "Minor"
        }
    }
}

enum DetailExtraRows: Int {
    case Proximity = 0
    case RSSI
    case Battery
    
    static let count = Battery.rawValue + 1
    
    var Desc: String {
        switch self {
        case .Proximity: return "Proximity"
        case .RSSI: return "RSSI"
        case .Battery: return "Battery"
        }
    }
}

enum SectionInfo: Int {
    case Name = 0
    case DetailMain
    case DetailExtra
    
    var numOfRows: Int {
        switch self {
        case .Name: return NameRows.count
        case .DetailMain: return DetailMainRows.count
        case .DetailExtra: return DetailExtraRows.count
        }
    }
    
    var title: String {
        switch self {
        case .Name: return "Beacon Name"
        case .DetailMain: return "Device Detail"
        case .DetailExtra: return "Addtional Information"
        }
    }
    
    var rowTitles: Array<String> {
        switch self {
        case .Name: return [NameRows.Name.Desc]
        case .DetailMain: return [DetailMainRows.UUID.Desc, DetailMainRows.Major.Desc, DetailMainRows.Minor.Desc]
        case .DetailExtra: return [DetailExtraRows.Proximity.Desc, DetailExtraRows.RSSI.Desc, DetailExtraRows.Battery.Desc]
        }
    }
    
    static let count = DetailExtra.rawValue + 1
}

class BeaconDetailViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    let kBeaconNameCell = "BeaconNameCell"
    let kBeaconDefaultCell = "BeaconDefaultCell"
    
    private var orgBeacon: Beacon?
    private var newBeacon: Beacon?
    private var beaconInfo: [[Int:String]] = [[Int:String]]()
    var beaconImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Edit Beacon"
        
        initializeTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        BeaconAPI.sharedInstance.beaconProtocol = self
        BeaconAPI.sharedInstance.startSearchingBeacons()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Event handler
    @IBAction func cancelButtonTapped(sender: AnyObject) {        
        BeaconAPI.sharedInstance.stopSearchingBeacons()
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject)
    {
        // TODO: Validation
        
        // Save updated Beacon
        if let newBeacon = newBeacon {
             Database.save(newBeacon)
        } else {
            print("Couldn't save the updated beacon because it's nil")
        }
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func deleteButtonTapped(sender: AnyObject) {        
        // Remove Beacon
        if case let beacon = self.orgBeacon where self.orgBeacon?.id.isEmpty == false {
            BeaconAPI.sharedInstance.stopSearchingBeacons()
            Database.delete(beacon!)
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: - Private Functions
    func initializeTableView() {
        tableView.registerNib(UINib.init(nibName: kBeaconNameCell, bundle: nil), forCellReuseIdentifier: kBeaconNameCell)
        tableView.registerNib(UINib.init(nibName: kBeaconDefaultCell, bundle: nil), forCellReuseIdentifier: kBeaconDefaultCell)
    }
    
    func selectedBeacon(beacon: Beacon) {
        orgBeacon = beacon
        
        beaconInfo.append([NameRows.Name.rawValue : beacon.name])
        beaconInfo.append([DetailMainRows.UUID.rawValue : beacon.id,
                          DetailMainRows.Major.rawValue : String(beacon.major),
                          DetailMainRows.Minor.rawValue : String(beacon.minor)])
        beaconInfo.append([DetailExtraRows.Proximity.rawValue : "", DetailExtraRows.RSSI.rawValue : ""])
    }
}

extension BeaconDetailViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionInfo.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = SectionInfo(rawValue: section) else {
            return ""
        }
        
        return sectionInfo.title
    }
}

extension BeaconDetailViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = SectionInfo(rawValue: section) else {
            return 0
        }
        
        return sectionInfo.numOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sectionInfo: SectionInfo = SectionInfo(rawValue: indexPath.section)!
        switch sectionInfo {
        case .Name:
            let cell = tableView.dequeueReusableCellWithIdentifier(kBeaconNameCell, forIndexPath: indexPath) as! BeaconNameCell
            let rows: NameRows = NameRows(rawValue: indexPath.row)!
            switch rows {
            case .Name:
                if let imgBeaconName = beaconImageName {
                    cell.imgBeacon.image = UIImage(named: imgBeaconName)
                }
                
                if indexPath.section < beaconInfo.count {
                    cell.txtName.text = beaconInfo[indexPath.section][indexPath.row]
                } else {
                    cell.txtName.text = ""
                }
                cell.txtName.userInteractionEnabled = false
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(kBeaconDefaultCell, forIndexPath: indexPath) as! BeaconDefaultCell
            cell.lblTitle.text = sectionInfo.rowTitles[indexPath.row]
            if indexPath.section < beaconInfo.count {
                cell.txtValue.text = beaconInfo[indexPath.section][indexPath.row]
            } else {
                cell.txtValue.text = ""
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension BeaconDetailViewController: BeaconProtocol {
    // MARK: - BeaconDataSource
    func updatedBeacon() -> Beacon? {
        return orgBeacon
    }
    
    // MARK: - BeaconDelegate
    func beaconAPI(beaconAPI: BeaconAPI, didEnterRegion region: CLRegion) {
        print("didEnterRegion: \(region.identifier)")
    }
    
    func beaconAPI(beaconAPI: BeaconAPI, didExitRegion region: CLRegion) {
        print("didExitRegion: \(region.identifier)")
    }
    
    func beaconAPI(beaconAPI: BeaconAPI, didRangeBeacon beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        let beacon = beacons[0]
        
        print("Proximity: \(beacon.proximity.Desc()), RSSI: \(beacon.rssi)db")
        
        beaconInfo[SectionInfo.DetailExtra.rawValue] = [
            DetailExtraRows.Proximity.rawValue : beacon.proximity.Desc(),
            DetailExtraRows.RSSI.rawValue : String(beacon.rssi)]
        
        let cellProximity = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: DetailExtraRows.Proximity.rawValue, inSection: SectionInfo.DetailExtra.rawValue)) as! BeaconDefaultCell
        cellProximity.txtValue.text = beacon.proximity.Desc()
        
        let cellRssi = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: DetailExtraRows.RSSI.rawValue, inSection: SectionInfo.DetailExtra.rawValue)) as! BeaconDefaultCell
        cellRssi.txtValue.text = String(beacon.rssi)
    }
}

extension CLProximity {
    func Desc() -> String {
        switch self {
        case .Unknown: return "Unknown"
        case .Immediate: return "Immediate"
        case .Near: return "Near"
        case .Far: return "Far"
        }
    }
}
