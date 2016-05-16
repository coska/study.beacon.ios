//
//  TaskWizardBaseViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-05-02.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskWizardBaseViewController: UIViewController {

    var task: Task?
    
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Task Wizard"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelButtonTapped:")
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Notification
    
    // MARK: Notifications
    func keyboardWillShow(noti: NSNotification) {
        
        if nextButtonBottomConstraint != nil {
            let userInfo = noti.userInfo!
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
            let animateCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.integerValue
            let curve = UIViewAnimationOptions(rawValue: UInt(animateCurve! << 16))
            
            nextButtonBottomConstraint.constant = 225
            
            UIView.animateWithDuration(duration, delay: 0, options: curve, animations: {
                self.view.layoutIfNeeded()
                }, completion: { finished in
                    
            })
        }
    }
    
    func keyboardWillHide(noti: NSNotification) {
        if nextButtonBottomConstraint != nil {
            nextButtonBottomConstraint.constant = 0
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: { finished in
                    
            })
        }
    }
}

