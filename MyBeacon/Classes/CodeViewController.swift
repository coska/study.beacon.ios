//
//  CodeViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
// Open curly bracket is at the begining of a line.
{
    // variable
    var tableView: UITableView?
    
    // IBOutlet
    
    // MARK:- View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Public
    
    // MARK:- Even handler
    
    // MARK:- Notification

    // MARK:- Private
    
    // MARK:- UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
}
