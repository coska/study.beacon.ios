//
//  Database.swift
//  BeaconData
//
//  Created by thomas on 2016-04-18.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Database {

	static let sharedInstance = try! Realm()
	
	
	static func loadAll() -> [Object]
	{
		let results = Database.sharedInstance.objects(Object)
		var objects : [Object] = []
		
		for data in results
		{
			objects.append(data)
		}
		
		return objects
	}
	
	static func save(object:Object) -> Bool
	{
		var ret = false
		
		do {
			try! Database.sharedInstance.write {
				Database.sharedInstance.add(object, update: true)
				ret = true
			}
		}
		
		return ret
	}
	
	static func delete(object:Object) -> Bool
	{
		var ret = false
		
		do {
			try! Database.sharedInstance.write {
				Database.sharedInstance.delete(object)
				ret = true
			}
		}
		
		return ret
	}
	
	static func deleteAll(object:Object) -> Bool
	{
		var ret = false
		
		do {
			try! Database.sharedInstance.write {
				Database.sharedInstance.deleteAll()
				ret = true
			}
		}
		
		return ret
	}

}
