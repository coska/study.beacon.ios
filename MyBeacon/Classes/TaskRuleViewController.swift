//
//  TaskRuleViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

// Add implementation for time condition & location condition

class TaskRuleViewController: TaskWizardBaseViewController
{
    // MARK: View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nextButton.enabled = true
   
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Event handler
    
    func cancelButtonTapped(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
