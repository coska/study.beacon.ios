//
//  BeaconNameCell.swift
//  MyBeacon
//
//  Created by Dexter Kim on 2016-05-01.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class BeaconNameCell: UITableViewCell {

    @IBOutlet weak var imgBeacon: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgBeacon.backgroundColor = UIColor.blueColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
