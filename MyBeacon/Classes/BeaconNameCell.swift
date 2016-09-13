//
//  BeaconNameCell.swift
//  MyBeacon
//
//  Created by Dexter Kim on 2016-05-01.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

protocol BeaconNameCellDelegate {
    func didNameChanged(changedName: String)
}

class BeaconNameCell: UITableViewCell {

    @IBOutlet weak var imgBeacon: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    
    var delegate: BeaconNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txtName.delegate = self
        imgBeacon.backgroundColor = UIColor.blueColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BeaconNameCell: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        guard let delegate = self.delegate else { return }
        guard let text = textField.text else { return }
        
        delegate.didNameChanged(text)
    }
}
