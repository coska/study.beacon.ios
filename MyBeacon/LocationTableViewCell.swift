//
//  LocationTableViewCell.swift
//  MyBeacon
//
//  Created by thomas on 2016-06-19.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

protocol LocationTableViewCellDelegate {
    func didTappedSwitch(cell:LocationTableViewCell)
}

class LocationTableViewCell: UITableViewCell {

    var delegate:LocationTableViewCellDelegate!
    
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var switchType: UISwitch!
    
    @IBAction func switchValueChanged(sender: UISwitch)
    {
        delegate.didTappedSwitch(self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
    }
    
}
