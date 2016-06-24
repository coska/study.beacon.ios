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
        
        if let task = self.task {
            nameField.text = task.name
            nextButton.enabled = task.name.isEmpty == false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Privates
    
    func textFieldDidChange() {
        nextButton.enabled = !(nameField.text?.isEmpty)!
    }
    
    // MARK: Event handlers

    @IBAction func nextButtonTapped(sender: UIButton) {
        if nameField.text?.isEmpty == false {
            task = Task()
            task!.name = nameField.text!
        }
    }
    
    // MARK: Segeu
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue: \(segue.identifier)")
        let actionTypeViewController = segue.destinationViewController as! TaskWizardBaseViewController
        actionTypeViewController.task = task
    }
}

extension TaskNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

