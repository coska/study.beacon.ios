//
//  BeaconCustomTableViewCell.swift
//  MyBeacon
//
//  Created by Danny Lee on 2016-05-09.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class BeaconCustomTableViewCell: UITableViewCell {


    @IBOutlet weak var beaconNameLabel: UILabel!
    @IBOutlet weak var beaconImage: UIImageView!
    @IBOutlet weak var beaconUUIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
