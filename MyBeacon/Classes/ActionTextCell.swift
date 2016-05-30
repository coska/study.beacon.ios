//
//  ActionTextCell.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-05-28.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

protocol ActionTextCellDelegate: class {
    func textDidChange(text: String, atIndex index: Int)
}

class ActionTextCell: UITableViewCell {

    var delegate: ActionTextCellDelegate?
    var index: Int?
    
    @IBOutlet weak var textField: UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Privates
    
    func commonInit() {
        textField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    // MARK: Event handlers
    
    func textFieldDidChange() {
        delegate?.textDidChange(textField.text!, atIndex: index!)
    }
}
