//
//  TaskBeaconViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskBeaconViewController: TaskWizardBaseViewController
{
    private let cellIdentifier = "beaconCell"
    private var selectedRow = -1
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning()
    {
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

    // MARK: Event handler
    
    func cancelButtonTapped(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension TaskBeaconViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "Beacon"
        
        if selectedRow == indexPath.row {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }
}

extension TaskBeaconViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
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