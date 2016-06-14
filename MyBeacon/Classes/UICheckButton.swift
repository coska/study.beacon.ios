//
//  UICheckButton.swift
//  MyBeacon
//
//  Created by thomas on 2016-05-29.
//  Copyright © 2016 coska.com. All rights reserved.
//

import UIKit

public class UICheckButton: UIButton {
    
    var row : Int = -1
    var col : Int = -1
    
    init(row:Int, col:Int, origin:CGPoint, size:CGSize)
    {
        self.row = row
        self.col = col
        let x = origin.x + CGFloat(col) * size.width
        let y = origin.y + CGFloat(row) * size.height
        
        super.init(frame:CGRectMake(x, y, size.width, size.height))
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.addTarget(self, action: #selector(UICheckButton.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBInspectable var isChecked:Bool = false {
        didSet{
            self.updateButton()
        }
    }
    
    func updateButton() {
    	self.backgroundColor = isChecked ? UIColor.greenColor() : UIColor.clearColor()
    }
    
    func buttonClicked(sender:UIButton) {
        if(sender == self){
            isChecked = !isChecked
        }
    }
}
