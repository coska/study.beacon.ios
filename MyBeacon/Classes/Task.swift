//
//  Task.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Task: Object, Applicable {
	
	dynamic var name = ""
	let rules = List<Rule>()		// allow to validate multiple rules
	let actions = List<Action>()  // allow multiple actions
	let beacons = List<Beacon>()  // allow to be used in multiple beacons
	
	
	func Apply() -> Bool
	{
		//TODO get method to use Apply for List
		/*
		var ret = false
		
		for rule in rules
		{
			if !rule.Apply()
				break
		}
		
		
		return ret
		*/
		
		return false
	}
	
	
	//TODO
	// 1. Generic loadAll, save method in Database (done)
	// 2. To verify save and load in REalm browser
	// 3. Implement Rule related screens (Add Rules, Time & Location condition)
	
	
}
