//
//  Beacon.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Beacon: Object {
	
	dynamic var id : String = ""
	
	dynamic var major : Int = 0
	dynamic var minor : Int = 0
	
	let battery = RealmOptional<Int>()
	dynamic var name : String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	static func loadAll() -> [Beacon]
	{
		let results = Database.sharedInstance.objects(Beacon)
		var beacons : [Beacon] = []
		
		for data in results
		{
			beacons.append(data)
		}
		
		return beacons
	}
	
	static func save(beacon:Beacon) -> Bool
	{
		var ret = false
		try! Database.sharedInstance.write({
			Database.sharedInstance.add(beacon, update: true)
			ret = true
		})
		
		return ret
	}
	
}
