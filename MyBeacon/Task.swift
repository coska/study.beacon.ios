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
	
	
	static func loadAll() -> [Task]
	{
		let results = Database.sharedInstance.objects(Task)
		var tasks : [Task] = []
		
		for data in results
		{
			tasks.append(data)
		}
		
		return tasks
	}
	
	static func save(task:Task) -> Bool
	{
		var ret = false
		
		do {
			try! Database.sharedInstance.write {
				Database.sharedInstance.add(task, update: true)
				ret = true
			}
		}
		
		return ret
	}
	
}
