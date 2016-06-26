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
}
