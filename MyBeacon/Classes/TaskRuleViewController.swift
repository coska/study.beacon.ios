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
    
    let cellId = "LocationCell"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil),  forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        scrollView.contentSize = CGSizeMake(weekView.frame.width, weekView.frame.height + tableView.frame.height)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.addSubview(weekView)
        
        tableView.tableFooterView = UIView()
        scrollView.addSubview(tableView)
        
        view.addSubview(scrollView)
        
        updateUI()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        print("segue: \(segue.identifier)")
        
        applyRule()
        
        //let nextViewController = segue.destinationViewController as! TaskBeaconViewController
        //nextViewController.task = task
    }
    
    func updateUI()
    {
        loadRule(TaskData.editTask.rule)
        nextButton?.enabled = true
    }
    
    func loadRule(rule:RuleData)
    {
        let time = rule.time
        for row in 0..<Hours.names.count
        {
            for col in 0..<Days.names.count
            {
                weekView.setChecked(row, col:col, val: time.days[col][row])
            }
        }
        
        let location = rule.location
        var i : Int = 0
        for type in Locations.types
        {
            let checked = location.isApplicable(type)
            let indexPath = NSIndexPath(forRow: i, inSection:0)
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! LocationTableViewCell
            
            cell.labelType.text = Locations.names[indexPath.row]
            cell.switchType.setOn(checked, animated: false)
            i = i + 1
        }
        
    }
    
    func applyRule()
    {
        let rule = TaskData.editTask.rule
        
        for row in 0..<Hours.names.count
        {
            for col in 0..<Days.names.count
            {
                rule.time.days[col][row] = weekView.isChecked(row, col:col);
            }
        }
        
        let location = rule.location
        var i : Int = 0
        
        for type in Locations.types
        {
            let indexPath = NSIndexPath(forRow: i, inSection:0)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! LocationTableViewCell
            
            if cell.switchType.on {
                location.add(type)
            }
            else {
                location.remove(type)
            }
            
            i = i + 1
        }
    }
    
}


extension TaskRuleViewController: UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! LocationTableViewCell
        let location = TaskData.editTask.rule.location
        
        cell.labelType.text = Locations.names[indexPath.row]
        cell.switchType.setOn((location.isApplicable(Locations.types[indexPath.row])), animated: false)

        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Locations.names.count
    }
    
    func updateSwitchAtIndexPath(indexPath:NSIndexPath)
    {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
    	let sw = cell?.accessoryView as! UISwitch
        sw.setOn(!sw.on, animated:true)
    }
    
}

extension TaskRuleViewController: LocationTableViewCellDelegate
{
    func didTappedSwitch(cell: LocationTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)
        
        var location = Locations(rawValue:(TaskData.editTask.rule.location.type))
        location.insert(Locations.types[indexPath!.row])
        
        TaskData.editTask.rule.location.type = location.rawValue
        
    }
}
