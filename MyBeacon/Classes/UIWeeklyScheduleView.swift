//
//  UIWeeklyScheduleView.swift
//  MyBeacon
//
//  Created by thomas on 2016-06-07.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

public class UIWeeklyScheduleView: UIScrollView {

    let dayCount = CGFloat(Days.names.count)
    let hourCount = CGFloat(Hours.names.count)
    let fontName = "Courier New"
    let gapRatio = CGFloat(1.22)
    
    var dayWidth = CGFloat(0.0)
    var dayHeight = CGFloat(0.0)
    var hourWidth = CGFloat(0.0)
    var hourHeight = CGFloat(0.0)
    var cellWidth = CGFloat(0.0)
    var cellHeight = CGFloat(0.0)
    
    var labelDays : Array<UILabel>?
    var labelHours : Array<UILabel>?
    var checkWeek : [UICheckButton]?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSize()
        initHeaderDays()
        initHeaderHours()
        initTime()
    }
    
    func initSize()
    {
        var font = UIFont(name: fontName, size: 16.0)
        var str = Days.names[0] as NSString
        var rect = str.boundingRectWithSize(CGSizeMake(0,0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font!], context: nil)
        dayWidth = rect.width * gapRatio
        dayHeight = rect.height * gapRatio
        
        font = UIFont(name: fontName, size: 14.0)
        str = Hours.names[0] as NSString
        rect = str.boundingRectWithSize(CGSizeMake(0,0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font!], context: nil)
        hourWidth = rect.width * gapRatio
        hourHeight = rect.height * gapRatio
        
        cellWidth = dayWidth
        cellHeight = hourHeight
    }
    
    func initHeaderDays()
    {
        let font = UIFont(name: fontName, size: 16.0)
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
            label.textColor = UIColor.blueColor()
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            labelDays?.append(label)
            self.addSubview(label)
            x = x + cellWidth
        }
    }
    
    func initHeaderHours()
    {
        let font = UIFont(name: fontName, size: 14.0)
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
            label.frame = CGRectMake(x, y, hourWidth, cellHeight-1)
            label.textColor = UIColor.blackColor()
            label.backgroundColor = UIColor.lightGrayColor()
            label.textAlignment = NSTextAlignment.Center
            labelHours?.append(label)
            self.addSubview(label)
            y = y + cellHeight
        }

    }
    
    func initTime()
    {
        checkWeek = []
        
		let size = CGSize(width:cellWidth, height:cellHeight)
        let base = CGPoint(x:hourWidth, y:dayHeight)
        
        for col in 0..<Days.names.count
        {
            for row in 0..<Hours.names.count
            {
                let button = UICheckButton(row:row, col:col, origin:base, size:size)
                button.updateButton()
                checkWeek?.append(button)
                self.addSubview(button)
            }
        }
        
        self.scrollEnabled = true
        self.clipsToBounds = true
        self.contentSize = CGSizeMake(hourWidth + cellWidth*dayCount, dayHeight + cellHeight*hourCount)
        
    }
    
    func setChecked(row:Int, col:Int, val:Bool)
    {
        let button = checkWeek![col*Hours.names.count + row];
        button.isChecked = val
    }
    
}

