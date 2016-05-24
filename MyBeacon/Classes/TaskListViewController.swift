//
//  TaskListViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit
import RealmSwift


class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let kCellIdentifier = "taskCell"
    weak var delegate: HomeListDelegate?

    lazy var fakeDataSource: Array<String> =
    {
        return ["At Work", "At Home", "At Car"]
    }()
    
    lazy var actionIcon: Array<String> =
        {
            return ["action1.png", "action2.png", "action3.png"]
    }()
    
    lazy var ruleIcon: Array<String> =
        {
            return ["rule1.png", "rule2.png", "rule3.png"]
    }()

    lazy var tasks: [Task] = Database.loadAll(Task.self)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.fakeDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! TaskCustomTableViewCell
        cell.taskNameLabel?.text = self.fakeDataSource[indexPath.row]
        cell.actionIconImage?.image = UIImage(named: actionIcon[indexPath.row])
        cell.ruleIconImage?.image = UIImage(named: ruleIcon[indexPath.row])
        
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            fakeDataSource.removeAtIndex(indexPath.row)
            actionIcon.removeAtIndex(indexPath.row)
            ruleIcon.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let storyboard = UIStoryboard(name: "TaskRule", bundle: nil)
        let taskDetailViewController = storyboard.instantiateViewControllerWithIdentifier("TaskDetailViewController") as! TaskDetailViewController

        self.delegate?.willPushViewController(taskDetailViewController, animated: true)
    }

}
