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
        return ["Task 1", "Task 2", "Task 3"]
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
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = self.fakeDataSource[indexPath.row]
        
        return cell;
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let storyboard = UIStoryboard(name: "TaskRule", bundle: nil)
        let taskDetailViewController = storyboard.instantiateViewControllerWithIdentifier("TaskDetailViewController") as! TaskDetailViewController

        self.delegate?.willPushViewController(taskDetailViewController, animated: true)
    }

}
