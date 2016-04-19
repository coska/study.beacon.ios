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
	
	static func loadData() -> Preference
	{
		return Database.sharedInstance.objects(Preference).first!
	}
	
	static func saveData(pref:Preference) -> Bool
	{
		try! Database.sharedInstance.write {
			Database.sharedInstance.add(pref, update: true)
		}
		
		//TODO
		return true
	}

}

