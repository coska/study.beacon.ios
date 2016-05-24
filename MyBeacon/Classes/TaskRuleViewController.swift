//
//  TaskRuleViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit


// Add implementation for time condition & location condition

class TaskRuleViewController: UIViewController, CircleMenuDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var labelCondition: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    //    let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
    
    
    
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
        ("icon_search", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
        ("notifications-btn", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
        ("settings-btn", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
        ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1)),
        ]
    
    
    // MARK: View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Task Wizard"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelButtonTapped:")
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
        
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        
        
        // add time condition selector
        let timeSelector = CircleMenu(
        	frame: CGRect(x: 80, y: 200, width: 50, height: 50),
            normalIcon:"icon_menu",
            selectedIcon:"icon_close",
            buttonsCount: 5,
            duration: 1,
            distance: 80)
            timeSelector.backgroundColor = UIColor.lightGrayColor()
            timeSelector.delegate = self
            timeSelector.layer.cornerRadius = timeSelector.frame.size.width / 2.0
            view.addSubview(timeSelector)
        
        // add location condition selector
        let locationSelector = CircleMenu(
            frame: CGRect(x: 80, y: 400, width: 50, height: 50),
            normalIcon:"icon_menu",
            selectedIcon:"icon_close",
            buttonsCount: 5,
            duration: 1,
            distance: 80)
        locationSelector.backgroundColor = UIColor.lightGrayColor()
        locationSelector.delegate = self
        locationSelector.layer.cornerRadius = locationSelector.frame.size.width / 2.0
        view.addSubview(locationSelector)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Event handler
    
    func cancelButtonTapped(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: <CircleMenuDelegate>
    
    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(imageLiteral: items[atIndex].icon), forState: .Normal)
        
        // set highlited image
        let highlightedImage  = UIImage(imageLiteral: items[atIndex].icon).imageWithRenderingMode(.AlwaysTemplate)
        button.setImage(highlightedImage, forState: .Highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
    
    // MARK: UIPickerViewDelegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1 //TimeType.pickers[TimeType.MonthOfYear]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let ret = (TimeType.pickers[TimeType.MonthOfYear]?.count)!
        print("numberOfRowsInComponent =\(ret)")
        return ret
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let ret = TimeType.pickers[TimeType.MonthOfYear]![row] as? String
        print("row=\(row), \nrawdata=\(TimeType.pickers[TimeType.MonthOfYear]![row]) \ntitleForRow=\(ret)")
        return ret
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor.whiteColor();
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor.redColor();
        }
        else if(row == 2)
        {
            self.view.backgroundColor =  UIColor.greenColor();
        }
        else
        {
            self.view.backgroundColor = UIColor.blueColor();
        }
    }
    
}
