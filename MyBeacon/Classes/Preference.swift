//
//  Preference.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Preference: Object {
	
	dynamic var id = "Preference"
	dynamic var periodBeacon = 1000
	dynamic var useGps = false
	dynamic var periodCampedOn = 10000
	
	override static func primaryKey() -> String {
		return "id"
	}
	
	static func loadOne() -> Preference
	{
		// assume we have only one preference
		
		return Database.sharedInstance.objects(Preference).first!
	}
	
	static func save(pref:Preference) -> Bool
	{
		var ret = false
		
		do {
		 	try! Database.sharedInstance.write {
				Database.sharedInstance.add(pref, update: true)
				ret = true
			}
		}
		
		return ret
	}

}

