//
//  UIWeeklyScheduleView.swift
//  MyBeacon
//
//  Created by thomas on 2016-06-07.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

public class UIWeeklyScheduleView: UIView {

    let dayCount = CGFloat(Days.names.count)
    let hourCount = CGFloat(Hours.names.count)
    
    var dayWidth = CGFloat(0.0)
    var dayHeight = CGFloat(0.0)
    var hourWidth = CGFloat(0.0)
    var hourHeight = CGFloat(0.0)
    var cellWidth = CGFloat(0.0)
    var cellHeight = CGFloat(0.0)
    
    var labelDays : Array<UILabel>?
    var labelHours : Array<UILabel>?
    public var checkWeek = Array(count:(Days.names.count),repeatedValue:Array(count:(Hours.names.count), repeatedValue:UICheckButton(row: -1,col: -1, origin:CGPointMake(0,0), size: CGSizeMake(0,0))))
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update()
    {
        initSize()
        updateDays()
        updateHours()
        updateTime()
    }
    
    func initSize()
    {
        var font = UIFont(name: "Courier New", size: 16.0)
        var str = Days.names[0] as NSString
        var rect = str.boundingRectWithSize(CGSizeMake(0,0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font!], context: nil)
        dayWidth = rect.width
        dayHeight = rect.height
        
        font = UIFont(name: "Courier New", size: 14.0)
        str = Hours.names[0] as NSString
        rect = str.boundingRectWithSize(CGSizeMake(0,0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font!], context: nil)
        hourWidth = rect.width
        hourHeight = rect.height
        
        cellWidth = dayWidth
        cellHeight = hourHeight
        
        self.frame = CGRectMake(0, 0, hourWidth + cellWidth*dayCount, dayHeight+cellHeight * hourCount )
        
    }
    
    func updateDays()
    {
        let font = UIFont(name: "Courier New", size: 16.0)
        let y = CGFloat(0.0)
        var x = hourWidth
        
        labelDays = Array<UILabel>()
        for day in Days.names
        {
            let label = UILabel()
            label.text = day
            label.numberOfLines = 1
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            
            label.font = font
            label.frame = CGRectMake(x, y, cellWidth, dayHeight)
            label.textColor = UIColor.blackColor()
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            labelDays?.append(label)
            self.addSubview(label)
            x = x + cellWidth
        }
    }
    
    func updateHours()
    {
        let font = UIFont(name: "Courier New", size: 14.0)
        let x = CGFloat(0.0)
        
        var y = dayHeight
        labelHours = Array<UILabel>()
        for hour in Hours.names
        {
            let label = UILabel()
            label.text = " " + hour + " "
            label.numberOfLines = 1
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            
            label.font = font
            label.frame = CGRectMake(x, y, hourWidth, cellHeight)
            label.textColor = UIColor.blackColor()
            label.backgroundColor = UIColor.lightGrayColor()
            label.textAlignment = NSTextAlignment.Center
            labelHours?.append(label)
            self.addSubview(label)
            y = y + cellHeight
        }

    }
    
    func updateTime()
    {
		let size = CGSize(width:cellWidth, height:cellHeight)
        let base = CGPoint(x:hourWidth, y:dayHeight)
        for row in 0..<Hours.names.count
        {
            for col in 0..<Days.names.count
            {
                let button = UICheckButton(row:row, col:col, origin:base, size:size)
                button.updateButton()
                checkWeek[col][row] = button
                self.addSubview(button)
            }
        }
    }
    
    public func getCheckButton(row:Int, col:Int) -> UICheckButton {
        return checkWeek[col][row]
    }
    
}

