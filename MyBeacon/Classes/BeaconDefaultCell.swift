//
//  BeaconDefaultCell.swift
//  MyBeacon
//
//  Created by Dexter Kim on 2016-05-01.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class BeaconDefaultCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtValue: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
