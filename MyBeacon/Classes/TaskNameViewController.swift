//
//  TaskNameViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskNameViewController: TaskWizardBaseViewController
{

    @IBOutlet weak var nameField: UITextField!
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.addTarget(self, action: #selector(TaskNameViewController.textFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = TaskData.editTask.name
        nextButton.enabled = (TaskData.editTask.name.isEmpty == false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Privates
    
    func textFieldDidChange() {
        nextButton.enabled = !(nameField.text?.isEmpty)!
    }
    
    // MARK: Event handlers

    @IBAction func nextButtonTapped(sender: UIButton)
    {
        TaskData.editTask.name = nameField.text!
    }
}

extension TaskNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

