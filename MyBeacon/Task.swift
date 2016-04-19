//
//  Task.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Task: Object {
	
	dynamic var name = ""
	
	//dynamic var rules : [Rule] = []
	//dynamic var actions : [Action] = []
	//dynamic var beacons : [Beacon] = []
	
	let rules = List<Rule>()
	let actions = List<Action>()
	let beacons = List<Beacon>()
	
	static func loadData() -> [Task]
	{
		//TODO
		return []
	}
	
	static func saveData(beacons:[Task]) -> Bool
	{
		//TODO
		return false
	}
	
	
	
}
