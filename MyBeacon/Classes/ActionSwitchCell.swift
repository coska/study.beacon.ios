//
//  ActionSwitchCell.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-05-28.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

protocol ActionSwitchCellDelegate: class {
    func switchDidChange(status: String)
}

class ActionSwitchCell: UITableViewCell {

    var delegate: ActionSwitchCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
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

    // MARK: Privates
    
    func commonInit() {
        switchControl.addTarget(self, action: #selector(ActionSwitchCell.switchDidChange), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Event handlers
    
    func switchDidChange() {
        delegate?.switchDidChange(switchControl.on ? "on" : "off")
    }
}
