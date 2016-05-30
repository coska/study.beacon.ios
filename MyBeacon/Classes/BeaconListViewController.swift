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
        return ["Alex's Beacon", "Dexter's Beacon", "Thomas's Beacon"]
    }()
    
    lazy var fakeImageSource: Array<String> =
    {
       return ["canada.png", "germany.png", "uk.png"]
    }()
    
    lazy var fakeUUIDSource: Array<String> =
    {
        return ["F94DBB23-2266-7822-3782-57BEAC0952AC", "F94DBB23-2266-7822-3782-57BEAC0952AC", "F94DBB23-2266-7822-3782-57BEAC0952AC"]
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
        
        let storyboard = UIStoryboard(name: "BeaconDetail", bundle: nil)
        let beaconDetailViewController = storyboard.instantiateViewControllerWithIdentifier("BeaconDetailViewController") as! BeaconDetailViewController
        
        // Mock Data
        let results = Database.sharedInstance.objects(Beacon).filter("id = %@", "F94DBB23-2266-7822-3782-57BEAC0952AC")

        let orgBeacon: Beacon = results[0]
//        let orgBeacon = Beacon()
//        orgBeacon.id = "F94DBB23-2266-7822-3782-57BEAC0952AC"
//        orgBeacon.major = 51320
//        orgBeacon.minor = 45042
//        orgBeacon.name = "0117C55A175E"
        beaconDetailViewController.selectedBeacon(orgBeacon)
        
        self.delegate?.willPushViewController(beaconDetailViewController, animated: true)
    }
}
