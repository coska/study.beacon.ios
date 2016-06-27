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
    
    static var showCredit : Bool = false
    
    //lazy var fakeDataSource: Array<String> =
    //{
    //    return ["At Work", "At Home", "At Car"]
    //}()
    
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
    var imageView:UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        initCredit()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = Database.loadAll(Task.self)
        tableView.reloadData()
        
        displayCredit()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! TaskCustomTableViewCell
        let task = tasks[indexPath.row]
        cell.taskNameLabel?.text = task.name
        cell.actionIconImage?.image = UIImage(named: actionIcon[indexPath.row])
        cell.ruleIconImage?.image = UIImage(named: ruleIcon[indexPath.row])
        
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            tasks.removeAtIndex(indexPath.row)
            actionIcon.removeAtIndex(indexPath.row)
            ruleIcon.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let storyboard = UIStoryboard(name: "Task", bundle: nil)
        let taskWizardNavigation = storyboard.instantiateViewControllerWithIdentifier("TaskWizardNavigation") as! UINavigationController
        let taskWizardVC = taskWizardNavigation.topViewController as! TaskWizardBaseViewController
        taskWizardVC.task = tasks[indexPath.row]
        
        self.delegate?.willPushViewController(taskWizardVC, animated: true)
    }
    
    // MARK: credit
    
    func initCredit()
    {
        let gif = UIImage.gifWithName("coska.ble.study")
        imageView = UIImageView(image: gif)
        let imageSize = CGFloat(64.0)
        imageView!.frame = CGRect(x: (self.view.frame.width-imageSize)/2.0 ,y: (self.view.frame.height-imageSize)/2.0, width: imageSize, height: imageSize)
        imageView!.userInteractionEnabled = true
        imageView!.layer.cornerRadius = 8.0
        imageView!.clipsToBounds = true
        
        let rec = UITapGestureRecognizer()
        rec.addTarget(self, action: #selector(creditImageTapped))
        imageView!.addGestureRecognizer(rec)
        imageView!.hidden = true
        view.addSubview(imageView!)
    }
    
    func displayCredit()
    {
        if TaskListViewController.showCredit {
        	imageView!.hidden = false
        }
    }
    
    func creditImageTapped()
    {
        imageView!.removeFromSuperview()
        TaskListViewController.showCredit = false
    }

}
