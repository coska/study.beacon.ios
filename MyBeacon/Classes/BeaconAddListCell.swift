//
//  BeaconAddListCell.swift
//  MyBeacon
//
//  Created by Dexter Kim on 2016-05-15.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconAddListCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblUUID: UILabel!
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblMinor: UILabel!
    @IBOutlet weak var lblProximity: UILabel!
    @IBOutlet weak var lblRSSI: UILabel!
    
    var beacon: CLBeacon? {
        didSet {
            guard let beacon = beacon else { return }
            
            self.lblUUID.text = beacon.proximityUUID.UUIDString
            self.lblMajor.text = "Major: " + String(beacon.major)
            self.lblMinor.text = "Minor: " + String(beacon.minor)
            self.lblProximity.text = "Proximity: " + beacon.proximity.Desc()
            self.lblRSSI.text = "RSSI: " + String(beacon.rssi)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor.grayColor().CGColor
        containerView.layer.borderWidth = 1.5
        containerView.layer.cornerRadius = 4.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
