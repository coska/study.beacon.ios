//
//  Task.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift
import CoreLocation

class Task: Object {
	dynamic var name = ""
	let rules = List<Rule>()	  // allow to validate multiple rules
	let actions = List<Action>()  // allow multiple actions
	let beacons = List<Beacon>()  // allow to be used in multiple beacons
	
    dynamic var enabled: Bool = false

    override static func primaryKey() -> String? {
        return "name"
    }
    
	// check all rules are valid
	func isApplicable(cl:CLLocation) -> Bool
	{
		var ret = (rules.count != 0)
		
		for rule in rules
		{
			if (!rule.isApplicable(cl))
			{
				ret = false
				break
			}
		}
		
		return ret
	}
    
    func fromData(data:TaskData)
    {
        name = data.name
        enabled = data.enabled
        
        rules.removeAll()
        let rule = Rule()
        rule.fromData(data.rule)
        rules.append(rule)
        
        actions.removeAll()
        let action = Action()
        action.fromData(data.action)
        actions.append(action)
        
        beacons.removeAll()
        let beacon = Beacon()
        beacon.fromData(data.beacon)
        beacons.append(beacon)
    }
}

class TaskData {
    dynamic var name = ""
    let rule = RuleData()
    let action = ActionData()
    let beacon = BeaconData()
    
    var enabled: Bool = false
    
    private static var _editTask:TaskData?
    static var editTask:TaskData {
        get {
            if (_editTask == nil) {
                _editTask = TaskData()
            }
            return _editTask!
        }
        set {
            _editTask = newValue
        }
    }
    
    func fromObject(o:Task)
    {
        name = o.name
        rule.fromObject(o.rules[0])
        action.fromObject(o.actions[0])
        beacon.fromObject(o.beacons[0])
        enabled = o.enabled
    }
    
}

