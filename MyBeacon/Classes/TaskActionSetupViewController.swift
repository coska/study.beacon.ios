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

        values = [String]()
        setupUI()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Privates
    
    private func setupUI() {
        
    	let action = TaskData.editTask.action
        switch (action.type) {
            case ActionType.Text.rawValue: setupText(action)
            case ActionType.Call.rawValue: setupCall(action)
            case ActionType.Wifi.rawValue: setupWifi(action)
            default: return
        }
        
        updateNextButtonStatus()
        tableView.tableFooterView = UIView()
    }
    
    private func actionType() -> String {
        let action = TaskData.editTask.action
        return action.type
    }
    
    private func setupText(action: ActionData) {
        values!.append(action.name ?? "")
        let actionValues = action.value.componentsSeparatedByString("|")
        values!.append(actionValues.first! ?? "")
        values!.append(actionValues.last! ?? "")

        actionData = [
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Name", "value": values![0]],
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Phone Number", "value": values![1]],
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Text", "value": values![2]],
        ]
    }
    
    private func setupCall(action: ActionData) {
        values!.append(action.name ?? "")
        values!.append(action.value ?? "")

        actionData = [
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Name", "value": values![0]],
            ["cellType": ActionCellType.Text.rawValue, "placeHolderString": "Phone Number", "value": values![1]]
        ]
    }
    
    private func setupWifi(action: ActionData) {
        values!.append(action.value ?? "")
        
        actionData = [
            ["cellType": ActionCellType.Switch.rawValue, "placeHolderString": "WiFi", "value": values![0]]
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
        let action = TaskData.editTask.action
        
        if actionType() == ActionType.Call.rawValue {
            action.name = (values?.first)!
            action.value = (values?[1])!
        } else if actionType() == ActionType.Text.rawValue {
            action.name = (values?.first)!
            action.value = "\((values?[1])!)|\((values?[2])!)"
        } else if actionType() == ActionType.Wifi.rawValue {
            action.name = "WiFi"
            action.value = (values?.first)! == "" ? "on" : (values?.first)!
        }
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
            cell.textField.text = item!["value"]
            cell.index = indexPath.row
            cell.delegate = self
            
            return cell
        } else if item!["cellType"] == ActionCellType.Switch.rawValue {
            let cell = tableView.dequeueReusableCellWithIdentifier(switchCellIdentifier, forIndexPath: indexPath) as! ActionSwitchCell
            cell.titleLabel.text = item!["placeHolderString"]
            cell.switchControl.on = item!["value"] == "on" ? true : false
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
