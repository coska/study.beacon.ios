//
//  HomeViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

enum ListType: Int
{
    case Beacon
    case Task
}

protocol HomeListDelegate: class {
    func willPushViewController(viewController: UIViewController, animated: Bool)
}

class HomeViewController: UIViewController, HomeListDelegate {
    private var currentDisplayListType: ListType?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    // MARK: Lazy loading
    
    lazy var beaconListViewController: BeaconListViewController = {
        var vc = self.myStoryboard.instantiateViewControllerWithIdentifier("BeaconListViewController") as! BeaconListViewController
        vc.delegate = self
        return vc
    }()
    
    lazy var taskListViewController: TaskListViewController = {
        var vc = self.taskListStoryboard.instantiateViewControllerWithIdentifier("TaskListViewController") as! TaskListViewController
        vc.delegate = self
        return vc
    }()
    
    lazy var beaconDetailStoryboard: UIStoryboard = {
            let sb = UIStoryboard(name: "BeaconDetail", bundle: nil)
            return sb
    }()
    
    lazy var myStoryboard: UIStoryboard = {
        let sb = UIStoryboard(name: "BeaconList", bundle: nil)
        return sb
    }()
    
    lazy var taskListStoryboard: UIStoryboard = {
            let sb = UIStoryboard(name: "TaskList", bundle: nil)
            return sb
    }()

    lazy var taskStoryboard: UIStoryboard = {
        let sb = UIStoryboard(name: "Task", bundle: nil)
        return sb
    }()

    // MARK: View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.displayListType(.Beacon)
		
		//TODO remove the followings (just for quick test)
		//let pref = Database.loadOne(Preference.self, create: true)
		//print(pref.description)
		
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateDisplayList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Event handler
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        let listType = sender.selectedSegmentIndex == 0 ? ListType.Beacon : ListType.Task
        self.displayListType(listType)
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        if self.segmentControl.selectedSegmentIndex == ListType.Beacon.rawValue
        {            
            let beaconAddNavigation = self.beaconDetailStoryboard.instantiateViewControllerWithIdentifier("BeaconAddNavigation") as! UINavigationController
            self.presentViewController(beaconAddNavigation, animated: true, completion: nil)
        }
        else
        {
            let taskWizardNavigation = self.taskStoryboard.instantiateViewControllerWithIdentifier("TaskWizardNavigation")
            self.presentViewController(taskWizardNavigation, animated: true, completion: nil)
        }
    }

    // MARK: Private
    func updateDisplayList() {
        if let listType = currentDisplayListType {
            switch listType {
            case .Beacon:
                self.beaconListViewController.updateBeaconList()
            case .Task:
                break;
            }
        }
    }
    
    func displayListType(listType: ListType) {
        currentDisplayListType = listType
        if listType == .Beacon
        {
            // TODO We can implement a better way to show/hide beacon/task view later.
            if self.beaconListViewController.view.superview == nil
            {
                if self.taskListViewController.view.superview != nil
                {
                    self.taskListViewController.view.removeFromSuperview()
                }
                self.containerView.addSubview(self.beaconListViewController.view)
                self.beaconListViewController.view.alignTop("0", leading: "0", bottom: "0", trailing: "0", toView: self.containerView)
            }
        }
        else
        {
            if self.taskListViewController.view.superview == nil
            {
                if self.beaconListViewController.view.superview != nil
                {
                    self.beaconListViewController.view.removeFromSuperview()
                }
                self.containerView.addSubview(self.taskListViewController.view)
                self.taskListViewController.view.alignTop("0", leading: "0", bottom: "0", trailing: "0", toView: self.containerView)
            }
        }
    }
    
    // MARK: HomeListDelegate
    
    func willPushViewController(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}
