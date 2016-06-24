//
//  TaskActionViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskActionViewController: TaskWizardBaseViewController {
    
    enum ActionCellIndex: Int {
        case Text = 0
        case Call
        case Wifi
    }
    
    private let cellIdentifier = "actionTypeCell"
    private var selectedRow = -1
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var actionTypes: [String] = {
        var types = ActionType.names as [String]
        types.removeFirst()
        return types
    }()
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Privates

    private func setupUI() {
        tableView.tableFooterView = UIView()
        updateNextButtonStatue(selectedRow)
    }
    
    func updateNextButtonStatue(row: Int) {
        nextButton?.enabled = row != -1
    }
    
    // MARK: Segeu
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let action = Action()
        action.type = actionTypes[selectedRow]

        if !task!.actions.isEmpty {
            task!.actions.replace(0, object: action)
        } else {
            task!.actions.insert(action, atIndex: 0)
        }
        
        let actionSetupViewController = segue.destinationViewController as! TaskWizardBaseViewController
        actionSetupViewController.task = task
    }
}

// MARK: UITableViewDataSource

extension TaskActionViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = actionTypes[indexPath.row]
        
        if selectedRow == indexPath.row {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionTypes.count
    }
}

// MARK: UITableViewDelegate

extension TaskActionViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let actionCellIndex = ActionCellIndex(rawValue: indexPath.row)
        
        if cell?.accessoryType == .Checkmark {
            cell?.accessoryType = .None
            selectedRow = -1
        } else {
            if selectedRow != -1 {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedRow, inSection: indexPath.section))
                cell?.accessoryType = .None
            }
            cell?.accessoryType = .Checkmark
            selectedRow = indexPath.row
        }
        
        updateNextButtonStatue(selectedRow)

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
