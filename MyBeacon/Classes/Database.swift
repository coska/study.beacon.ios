//
//  Database.swift
//  BeaconData
//
//  Created by thomas on 2016-04-18.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift


class Database
{
	static let sharedInstance = try! Realm()
	
	static func loadAll<T:Object>(type:T.Type) -> [T]
	{
		let results = Database.sharedInstance.objects(T)
		var objects : [T] = []
		
		for data in results
		{
			objects.append(data)
		}
		
		return objects
	}
	
	static func loadOne<T:Object>(type:T.Type, create:Bool) -> T
	{
		let results = Database.sharedInstance.objects(T)
		if (create && results.isEmpty)
		{
			save(T())
		}
		
		return Database.sharedInstance.objects(T).first!
	}
	
	static func save<T:Object>(object:T) -> Bool
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
	
	static func delete<T:Object>(object:T) -> Bool
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
	
	static func deleteAll<T:Object>(object:T) -> Bool
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
    
    static func update<T:Object>(object:T, key: String, value:AnyObject) -> Bool {
        var ret = false
        
        do {
            try! Database.sharedInstance.write{
                object.setValue(value, forKey: key)
                ret = true
            }
        }
        
        return ret
    }

}
