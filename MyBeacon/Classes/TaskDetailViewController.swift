//
//  TaskDetailViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editButtonTapped")
        self.title = "Task View"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Event handler
    
    func editButtonTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let taskWizardNavigation = storyboard.instantiateViewControllerWithIdentifier("TaskWazardNavigation")
        self.presentViewController(taskWizardNavigation, animated: true, completion: nil)
    }
}
