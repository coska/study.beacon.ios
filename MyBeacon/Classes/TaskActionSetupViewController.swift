//
//  TaskActionSetupViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskActionSetupViewController: TaskWizardBaseViewController
{

    // MARK: View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
