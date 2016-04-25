//
//  CodeViewController.swift
//  MyBeacon
//
//  Created by Alex Lee on 2016-04-17.
//  Copyright © 2016 Coska. All rights reserved.
//

import UIKit

// enum
enum SectionInfo: Int {
    case BeaconName
    case BasicInfo
    case AdditionalInfo
    
    var numOfRows: Int {
        switch self {
        case .BeaconName: return 1
        case .BasicInfo: return 2
        case .AdditionalInfo: return 3
        }
    }
    
    var description: String {
        switch self {
        case .BeaconName: return "Beacon Name"
        case .BasicInfo: return "Basic Information"
        case .AdditionalInfo: return "Additional Information"
        }
    }
}

class CodeViewController: UIViewController {
// Open curly bracket is at the begining of a line.

    // variable
    // Getter
    var readOnlyProperty: Bool {
        return true
    }
    // Setter
    var setterProperty: String {
        didSet {
            if self.readOnlyProperty == true {
                setterProperty = "true"
            } else {
                setterProperty = "false"
            }
            print("\(setterProperty)")
        }
    }
    // Optional
    var optionalProperty: String?
    // Lazy
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
    }()
    
    // IBOutlet
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTableVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Public
    func regularFunction(first: Int, second: String) -> String {
        
        // guard
        guard first > 0 else { return "" }
        
        return ""
    }
    
    // MARK:- Even handler
    
    // MARK:- Notification

    // MARK:- Private
    private func privateFunction() {
        
    }
    
    // MARK:- Internal
    internal func initializeVC() {
        
    }
}

extension CodeViewController: UITableViewDataSource {
    // MARK:- UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
}

extension CodeViewController: UITableViewDelegate {
    
}
