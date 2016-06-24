//
//  TaskActionSetupViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

enum ActionCellType: String {
    case Text = "Text"
    case Switch = "Switch"
}

class TaskActionSetupViewController: TaskWizardBaseViewController
{
    private let textCellIdentifier = "textCell"
    private let switchCellIdentifier = "switchCell"
    private var actionData: [[String: String]]?
    private var values: [String]?
    @IBOutlet weak var tableView: UITableView!

    // MARK: View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        values = [String](count: (actionData?.count)!, repeatedValue: "")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Privates
    
    private func setupUI() {
        
        if let action = task!.actions.first {
            switch (action.type) {
            case ActionType.Text.rawValue: setupText()
            case ActionType.Call.rawValue: setupCall()
            case ActionType.Wifi.rawValue: setupWifi()
            default: return
            }
        }

        tableView.tableFooterView = UIView()
    }
    
    private func actionType() -> String {
        let action = task!.actions.first
        return (action?.type)!
    }
    
    private func setupText() {
        actionData = [
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Name"],
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Phone Number"],
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Text"],
        ]
    }
    
    private func setupCall() {
        actionData = [
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Name"],
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Phone Number"]
        ]
    }
    
    private func setupWifi() {
        actionData = [
            ["cellType": ActionCellType.Switch.rawValue, "placeHolderString": "WiFi"]
        ]
        nextButton.enabled = true
    }
    
    private func updateNextButtonStatus() {
        if actionType() != ActionType.Wifi.rawValue {
            nextButton.enabled = values?.filter({$0.isEmpty}).count == 0
        }
    }
    
    // MARK: Event handler    
    @IBAction func nextButtonTapped(sender: UIButton) {
        let action = task!.actions.first
        if actionType() == ActionType.Call.rawValue {
            action!.name = (values?.first)!
            action!.value = (values?[1])!
        } else if actionType() == ActionType.Text.rawValue {
            action!.name = (values?.first)!
            action!.value = "\((values?[1])!)|\((values?[2])!)"
        } else if actionType() == ActionType.Wifi.rawValue {
            action!.name = "WiFi"
            action!.value = (values?.first)! == "" ? "on" : (values?.first)!
        }
    }

    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let actionSetupViewController = segue.destinationViewController as! TaskWizardBaseViewController
        actionSetupViewController.task = task
    }
}

extension TaskActionSetupViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (actionData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = actionData?[indexPath.row] as [String: String]?
        
        if item!["cellType"] == ActionCellType.Text.rawValue {
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! ActionTextCell
            cell.textField.placeholder = item!["placeHolderString"]
            cell.index = indexPath.row
            cell.delegate = self
            
            return cell
        } else if item!["cellType"] == ActionCellType.Switch.rawValue {
            let cell = tableView.dequeueReusableCellWithIdentifier(switchCellIdentifier, forIndexPath: indexPath) as! ActionSwitchCell
            cell.titleLabel.text = item!["placeHolderString"]
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension TaskActionSetupViewController: ActionTextCellDelegate {
    func textDidChange(text: String, atIndex index: Int) {
        values![index] = text
        updateNextButtonStatus()
    }
}

extension TaskActionSetupViewController: ActionSwitchCellDelegate {
    func switchDidChange(status: String) {
        values![0] = status
    }
}
