//
//  TaskCustomTableViewCell.swift
//  MyBeacon
//
//  Created by Danny Lee on 2016-05-10.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var actionIconImage: UIImageView!
    @IBOutlet weak var ruleIconImage: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
