//
//  TaskRuleViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskRuleViewController: TaskWizardBaseViewController
{
    @IBOutlet weak var weekView: UIWeeklyScheduleView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if (task?.rules.count == 0)
        {
            let rule = Rule()
            rule.name = "no name"
            rule.time = TimeCondition()
            rule.location = LocationCondition()
            task?.rules.append(rule)
        }
        loadSchedule((task?.rules[0].time)!)
        loadLocation((task?.rules[0].location)!)
        
        scrollView.contentSize = CGSizeMake(weekView.frame.width, weekView.frame.height + tableView.frame.height)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.addSubview(weekView)
        scrollView.addSubview(tableView)
        
        view.addSubview(scrollView)
        
        nextButton.enabled = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func cancelButtonTapped(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadSchedule(time:TimeCondition)
    {
        for row in 0..<Hours.names.count
        {
            for col in 0..<Days.names.count
            {
                weekView.setChecked(row, col:col, val: time.days[col][row])
            }
        }
    }
    
    func loadLocation(location:LocationCondition)
    {
        switch (LocationType.getType(location.type))
        {
        case .None, .NoSignal:
            break
        case .Far:
            break
        case .Immediate:
            break
        case .Near:
            break
        }
    }
}

