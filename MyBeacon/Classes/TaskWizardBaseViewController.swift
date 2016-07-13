//
//  TaskWizardBaseViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-05-02.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class TaskWizardBaseViewController: UIViewController {

    let activeColor = UIColor(colorLiteralRed: 0.0/255, green: 136.0/255, blue: 43.0/255, alpha: 1)
    let inactiveColor = UIColor.grayColor()
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.addObserver(self, forKeyPath: "enabled", options: .New, context: nil)
        setupUI()
        setupNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        nextButton.removeObserver(self, forKeyPath: "enabled")
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        if self.presentingViewController != nil {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    // MARK: Privates
    
    private func setupUI() {
        self.title = "Task Wizard"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(TaskWizardBaseViewController.cancelButtonTapped(_:)))
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        nextButton.enabled = false
    }

    private func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TaskWizardBaseViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TaskWizardBaseViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
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
    
    func checkCredit(task:Task) ->Bool
    {
        return task.name == "coska ble study"
    }
    
    // MARK: KVO
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if ((object?.isEqual(nextButton)) != nil) {
            let enabled = change!["new"] as! Int
            nextButton.backgroundColor = enabled == 1 ? activeColor : inactiveColor
        }
    }
}

